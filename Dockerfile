# buz — all-in-one recon & scan chain
# Build:  docker build -t buz .
# Run:    docker run --rm -v "$PWD/out:/out" buz -u example.com -y -o /out
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive \
    GOPATH=/root/go \
    PATH=/root/go/bin:/root/.local/bin:/usr/local/go/bin:/usr/bin:/bin:/usr/sbin:/sbin

# --- apt tool'lar + build muhiti ---
RUN apt-get update && apt-get install -y --no-install-recommends \
      golang git curl wget python3 python3-pip pipx ruby-full ca-certificates \
      nmap masscan nikto whatweb dirb sqlmap amass feroxbuster seclists \
      massdns sslscan jq dnsutils && \
    rm -rf /var/lib/apt/lists/*

# --- ProjectDiscovery + boshqa go tool'lar ---
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest && \
    go install -v github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest && \
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest && \
    go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest && \
    go install -v github.com/d3mondev/puredns/v2@latest && \
    go install -v github.com/tomnomnom/assetfinder@latest && \
    go install -v github.com/lc/gau/v2/cmd/gau@latest && \
    go install -v github.com/tomnomnom/waybackurls@latest && \
    go install -v github.com/tomnomnom/gf@latest && \
    go install -v github.com/tomnomnom/qsreplace@latest && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/hahwul/dalfox/v2@latest && \
    go install -v github.com/ffuf/ffuf/v2@latest && \
    go install -v github.com/OJ/gobuster/v3@latest && \
    go install -v github.com/sensepost/gowitness@latest && \
    go install -v github.com/lc/subjs@latest && \
    go install -v github.com/KathanP19/Gxss@latest && \
    go install -v github.com/Emoe/kxss@latest && \
    go install -v github.com/PentestPad/subzy@latest && \
    go install -v github.com/hakluke/hakrawler@latest && \
    go install -v github.com/jaeles-project/gospider@latest && \
    go install -v github.com/Josue87/gotator@latest && \
    go install -v github.com/gwen001/github-subdomains@latest && \
    go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest && \
    go install -v github.com/devploit/nomore403@latest && \
    rm -rf /root/go/pkg /root/.cache

# --- python tool'lar ---
RUN pip3 install --no-cache-dir --break-system-packages \
      arjun wafw00f dirsearch dnsgen ghauri || true

# --- nuclei templatelari ---
RUN nuclei -update-templates || true

COPY buz /usr/local/bin/buz
RUN chmod +x /usr/local/bin/buz

WORKDIR /out
ENTRYPOINT ["buz"]
CMD ["-h"]
