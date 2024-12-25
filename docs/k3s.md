# Kubernetes Einrichtung

## Quick Setup

* /boot/firmware/cmdline.txt
  ```bash
  cgroup_memory=1 cgroup_enable=memory
  ```
* Aktivierung per `sed`
  ```bash
  sudo sed -i '1 s|$| cgroup_memory=1 cgroup_enable=memory|' /boot/firmware/cmdline.txt
  ```
* Vor Reboot: `cat /proc/cgroups`
  ```bash
  #subsys_name	hierarchy	num_cgroups	enabled
  cpuset	0	66	1
  cpu	0	66	1
  cpuacct	0	66	1
  blkio	0	66	1
  memory	0	66	0
  devices	0	66	1
  freezer	0	66	1
  net_cls	0	66	1
  perf_event	0	66	1
  net_prio	0	66	1
  pids	0	66	1
  ```

```bash
sudo curl -sfL https://get.k3s.io | sh -
```
Quelle: <https://docs.k3s.io/quick-start>