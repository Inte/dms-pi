#!/bin/bash

# Funktion zum Überprüfen und Hinzufügen/Ändern der Zeitzone
set_timezone() {
    local service_file=$1
    local new_timezone="Europe/Berlin"
    local env_var="Environment=\"TZ=$new_timezone\""
    
    # Überprüfen, ob bereits eine Zeitzone gesetzt wurde
    if grep -q 'Environment="TZ=' "$service_file"; then
        # Wenn ein TZ-Eintrag vorhanden ist, wird der alte Eintrag ersetzt
        sudo sed -i "s/Environment=\"TZ=[^\"]*\"/$env_var/" "$service_file"
        echo "Zeitzonen-Eintrag in $service_file geändert auf $new_timezone."
    else
        # Falls kein TZ-Eintrag vorhanden ist, wird der neue Eintrag hinzugefügt
        echo "$env_var" | sudo tee -a "$service_file" > /dev/null
        echo "Zeitzonen-Eintrag zu $service_file hinzugefügt."
    fi
}

# Funktion zum Überprüfen, ob der K3s-Dienst installiert ist
check_and_set_timezone_for_service() {
    local service_file=$1
    local service_name=$2

    # Prüfen, ob der Dienst existiert
    if systemctl list-units --type=service --all | grep -q "$service_name"; then
        echo "$service_name ist installiert. Zeitzone wird gesetzt..."
        set_timezone "$service_file"
    else
        echo "$service_name ist nicht installiert. Zeitzone wird nicht geändert."
    fi
}

# Pfade zu den K3s-Service-Dateien
K3S_SERVER_SERVICE="/etc/systemd/system/k3s.service"
K3S_AGENT_SERVICE="/etc/systemd/system/k3s-agent.service"

# Prüfen und Zeitzone setzen, falls K3s oder K3s-Agent installiert sind
check_and_set_timezone_for_service "$K3S_SERVER_SERVICE" "k3s.service"
check_and_set_timezone_for_service "$K3S_AGENT_SERVICE" "k3s-agent.service"

# Systemd neu laden und Dienste neu starten, wenn Änderungen vorgenommen wurden
if systemctl list-units --type=service --all | grep -q "k3s"; then
    echo "Systemd neu laden und K3s-Dienste neu starten..."
    sudo systemctl daemon-reload
    if systemctl list-units --type=service --all | grep -q "k3s.service"; then
        sudo systemctl restart k3s
    fi
    if systemctl list-units --type=service --all | grep -q "k3s-agent.service"; then
        sudo systemctl restart k3s-agent
    fi
    echo "K3s-Dienste wurden neu gestartet."
else
    echo "Kein K3s-Dienst gefunden. Keine Neustarts durchgeführt."
fi
