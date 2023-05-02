#!/bin/bash
# Config script to set up DNMP agents in Milax containers
# Author: Jialiang Chen
# Date: 03-05-2023
# Ver: 1.0

# Installing packages
if [[ ! $(dpkg -s snmp) ]]; then apt install -y snmp; else echo "[OK] snmp installed."; fi

if [[ ! $(dpkg -s snmpd) ]]; then apt install -y snmpd; else echo "[OK] snmpd installed."; fi

if [[ ! $(dpkg -s smistrip) ]]; then apt install -y smistrip; else echo "[OK] smistrip installed."; fi

if [[ ! $(dpkg -s patch) ]]; then apt install -y patch; else echo "[OK] patch installed."; fi

if [[ ! $(dpkg -s snmp-mibs-downloader) ]]; then apt install -y snmp-mibs-downloader; else echo "[OK] snmp-mibs-downloader installed."; fi

echo "-Finished checking packages..."
