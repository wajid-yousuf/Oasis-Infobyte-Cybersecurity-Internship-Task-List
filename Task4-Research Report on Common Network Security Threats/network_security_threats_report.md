**Research Report -- Common Network Security Threats**

Summary:\
This report explains three high-impact network security threats -- Denial of Service (DoS/DDoS), Man-in-the-Middle (MiTM) attacks, and Spoofing (IP/ARP/DNS/email).\
For each threat we describe how it works, typical impact, detection indicators, real-world examples, and practical mitigations you can apply at network, host, and \
organizational levels. The goal is to provide clear, actionable guidance useful for SOC analysts, network operators, and security engineers.\

**Introduction**\
Network connect users to services and that connectivity is a frequent target. Threats targeting availability, confidentiality, and trust are especially damaging.\
Understanding attack mechanics, indicators, and layered defenses helps reduce risk and respond faster when incidents occur.\

**What is Denial of Service (DoS) and Distributed Denial of Service (DDoS)?**\
A DoS attack attempts to make a network service unavailable to legitimate users by exhausting resources (bandwidth, CPU,\
memory, connection tables). A DDoS is a DoS performed from many distributed systems (a botnet), vastly increasing scale\
and complexity.
**How it works (common techniques)**
1). Volumetric Attacks -- flood link capacity (UDP floods, amplification attacks using open DNS/NTP/memcached).\
2). Protocol Attacks -- exploit protocol/state weaknesses (SYN flood, TCP connection table exhaustion).\
3). Application Layer Attacks -- flood expensive application endpoints (HTTP GET floods, slow-loris that holds connection open).\

**Impact of DDoS Attacks**\
> Service downtime or severe degradation (minutes -> days).\
> Revenue loss, reputational damage, and lost customer trust.\
> Collateral disruption to other services on shared infrastructure (ISP or data center impact).\
> Increased operational cost (mitigation, forensics, legal).\
** Detection Indicators **\
> Sudden, sustained spike in inbound traffic (volume, new flows).\
> Many short/failed TCP handshakes (SYN) or very high rates of small UDP packets.\
> High error rates, exhausted connection tables, or overloaded web servers.\
> Alerts from upstream providers or CDNs about abnormal traffic.\
**Real-World Examples**\
> Mirai / DYN (2016): IoT devices hijacked into Mirai botnet launched large-scale attacks against DNS provider Dyn, causing outages\
for many major sites.
> Github (2018): Massive memcached amplification attack peaked at multiple hundreds of Gbps/Tbps scale.\

**Mitigations & Defenses**\
Immediate/Operational:\
> Engage ISP/CDN scrubbing (cloud DDoS protection).\
> Rate-limit, blackhoke, or sinkhole malicious traffic at edge (careful: may cause collateral impact).\
> Scale application capacity (autoscaling) and move static assets to CDN.\

Architectural / Preventive\
> Use Anycast and multiple POPs to distribute traffic.\
> Close or secure amplification vectors (disable open resolvers, secure NTP, memcached).\
> Implement BCP38 (ingress filtering) at ISP\local network to block spoofed packets.\
> Maintain DDoS runbook and test incident playbooks regularly.\

**What is Man-in-the-Middle (MiTM) Attacks**
A MiTM attacker intercepts or modifies communications between two parties without their knowledge. The attacker can eavesdrop, modify\
messages, or impersonate one side.\

**How it works (common vectors)**\
> ARP spoofing/poisoning on LANs to intercept layer-2 traffic.\
> Rogue Wi-Fi hotspots / Evil-twin that collects user traffic.\
> DNS hijacking / cache poisoning that redirects victims to attacker-controlled hosts.\
> TLS/SSL downgrade or forged certificates (compromised CAs or TLS stripping).\
**Impact of MiTM**\
> Theft of credentials, session hijacking, data exfiltration.\
> Injection of malicious content (dirve-by download, script injection).\
> Undetected persistence if attacker modifies configurations or implants backdoors.\
**Detection Indicators**
> Multiple hosts reporting the same MAC for the gateway or sudden ARP table changes.\
> Unexpected TLS certificate chains, unknown issuers, or certificate transparency alerts.\
> DNS responses with unexpected addresses or anomalous TTLs.\
> Endpoint alerts for abnormal proxied traffic or credential theft.\
**Real-World Examples**
> DigiNotar CA compromise (2011): Fraudulent certificates were issued allowing nation-scale MiTM.\
> Frequent real-world rogue Wi-Fi attacks where attackers capture login credentials from public Wi-Fi users.\
**Mitigations & Defenses**\
Network & Transport:
> Enforce TLS everywhere; use HSTS and certificate pinning for critical apps.
> Deploy DNSSEC where feasible; use validated resolvers (DoT/DoH) with trusted resolvers.
LAN & Access
> Use 802.1x, DHCP snooping, and dynamic ARP inspection on switches.
> Use strong Wi-Fi (WPA/WPA3), disable open hotspots and WPS.
Operational
> Monitor certificate transparency logs and alert on unexpected certs.
> Educate users about certificate warnings and rogue Wi-Fi risks.
> Use endpoint EDR to detect credential theft or unusual process/network behaviour.
**What is Spoofing (IP/ARP/DNS/Email)**
> Spoofing is forging identity information (source IP, MAC address, DNS records, or email headers) to masquerade as another entity.
**Common Spoofing types & how they work**
> IP spoofing: Attacker sets source IP (used in reflection/amplification attacks or to bypass IP-based controls).
> ARP spoofing: Attacker injects fake MAC-IP mappings on LAN to redirect traffic (used for MiTM).
> DNS spoofing / cache poisoning: Attacker poisons DNS caches to return malicious IPs for legitimate domains.
> Email spoofing: Forging from headers; used heavily in phishing.
**Impact**
> Enables DDoS amplification, bypasses IP filtering, aids lateral movement.
> Leads to phishing, fraud, data theft, and trust erosion.
**Detection Indicators**
> Netflow showing many packets claiming to come from many different source IPs that do not respond to probes.
> ARP table anomalies: Multiple IPs mapped to same MAC, or rapid ARP churn.
> DNS records that diverge from authoritative data.
> Email delivery failures flagged by SPF/DKIM/DMARC checks.
**Some Real-World Examples**
> Smurf attacks (historical): Broadcast amplification using spoofed source addresses.
> Kaminsky DNS vulnerability (2008): Enabled practical cache poisoning attacks until patches.
**Mitigations & Defenses (Network)**
> Implement BCP38 / RFC 2827 (ingress filtering) to prevent packets with spoofed source addresses at network edges.
> Use RPKI and ROV for BGP security to mitigate route hijacking.
**DNS & Email (Mitigations & Defenses)**
> Deploy DNSSEC and secure DNS operations; monitor DNS for unexpected changes.
> Enforce SPF/DKIM/DMARC to reduce email spoofing and phishing.
**Application & Poilcy (Mitigations & Defenses)**
> Do not rely solely on source IP for authentication; use MFA and token-based authentication.
> Harden systems and monitor logs for anomalies.
**Detection, Monitoring and Incident Response (cross-cutting)**
Log sources to collect
> Network: NetFlow/IPFIX, firewall logs, IDS/IPS (Snort/Suricate), proxy logs.
> Host: syslog, Windows Event Logs, EDR telemetry.
> Application: Web Server access / error logs, database logs.
> DNS logs and TLS certificate logs.
**Detection Techniques**
> Threshold & anomaly detection for traffic spikes (DDoS).
> ARP/NDP anomaly detection and switch port security for MiTM / ARP spoofing.
> DNS response integrity checks and certificate monitoring.
> Use signature rules (Snort/Suricata) for known exploits and behavior-based detection for novel attacks.
**Incident response steps (high-level)**
> Identify -- confirm the event and scope (who, what, when).
> Contain -- Isolate affected assets or apply mitigation (blackhole DDoS traffic, isolate compromised hosts).
> Eradicate -- Remove mailcious artificats, close exploited vulnerabilites.
> Recover -- Restore services and validate integrity.
> Post-Incident -- Root cause analysis, update playbooks, apply lessons learned.
**Recomend Controls & Best Practices (Summary checklist)**
> Enforce TLS and strong cipher suites (HSTS, cert pinning where applicable).
> Use CDNs & DDoS protection for public-facing services.
> Deploy IDs/IPS (Snort/Suricata) + SIEM for correlation and alerting.
> Harden perimeter: Firewalls, ingress filtering (BCP38), and strict ACLs.
> Use MFA and avoid IP-only access controls.
> Implement SPF/DKIM/DMARC and monitor DNS changes (DNSSEC where feasible).
> Patch systems promptly; segment networks; remove unnecessary services.
> Maintain incident response playbooks and perform tabletop exerciese.
**Conclusion**
> DoS/DDoS, MiTM and spoofing attacks target fundamental network properites-availability, confidentiality, and integrity. Effective defense requires layered controls: network design (CDNs, Anycast, ingress filtering), protocol protections (TLS, DNSSEC), host/network hardening, and operational readiness (SIEM, Incident playbooks). Combining prevention, detection, and response reduces risk and shortens mean time to recovery when incidents occur.
**Appendix -- Useful Tools & Commands**
> Network & Packet capture: tcpdump, wireshark
> Flow analysis: ntop, NetFlow/IPFIX collectors.
> IDS/IPS: Snort, Suricata
> DDoS mitigation: Cloudflare, Akamai, AWS Shield
> TLS/DNS monitoring: Certificate Tranaparency logs, dig, drill.
> Log cenrtalization: ELK/Elastic, Splunk etc.
