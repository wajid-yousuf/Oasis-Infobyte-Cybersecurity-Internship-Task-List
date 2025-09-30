**Research Report -- Common Network Security Threats**\

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
Network & Transport:\
> 
