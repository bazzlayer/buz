# buz

Bitta buyruq bilan to'liq recon va skan. `buz -u example.com` deysiz — qolganini o'zi qiladi: kerakli tool'larni o'rnatadi, wordlistlarni tortadi, nmap'dan tortib nuclei, feroxbuster, sqlmap, dalfox gacha hammasini zanjir qilib ishlatadi.

```
   ____  _   _ _____
  | __ )| | | |__  /
  |  _ \| | | | / /
  | |_) | |_| |/ /_
  |____/ \___//____|
```

## O'rnatish

```bash
git clone https://github.com/bazzlayer/buz.git
cd buz
chmod +x buz
sudo ln -sf "$PWD/buz" /usr/local/bin/buz
```

Birinchi marta ishlatganda yo'q tool'larni o'zi o'rnatadi. Kali'da eng yaxshi ishlaydi.

Docker bilan:

```bash
docker build -t buz .
docker run --rm -v "$PWD/out:/out" buz -u example.com -y -o /out
```

## Ishlatish

```bash
buz -u example.com            # light: nmap -> feroxbuster (2 wordlist)
buz -u example.com --medium   # + nuclei
buz -u example.com --heavy    # + xss + sqlmap + crawl
buz -u example.com --full -y  # hammasi
```

### Og'irlik darajalari

| Daraja | Bayroq | Nima ishlaydi |
|--------|--------|---------------|
| light (default) | `--light` | nmap, keyin topilgan portlarga feroxbuster (medium + fuzz.txt) |
| medium | `--medium` | light + nuclei |
| heavy | `--heavy` | medium + xss (Gxss/kxss/dalfox) + sqlmap + crawl |
| full | `--full` / `-A` | hammasi: subdomain, takeover, cors, tls, cms, secrets, oob/dast, cloud, depx |

### Asosiy bayroqlar

| Bayroq | Ma'no |
|--------|-------|
| `-u <target>` | domen / IP / CIDR |
| `-l <fayl>` | ko'p target ro'yxat |
| `-o <dir>` | natija papkasi |
| `-t <n>` | threadlar |
| `--scope` / `--exclude` | qamrov fayllari |
| `--brute` | subdomain bruteforce + permutations |
| `--stealth` | sekin/yashirin + 403 bypass |
| `--proxy <url>` | Burp/proxychains orqali |
| `--cookie` / `--auth` / `--header` | login orqasidagi sahifalar uchun |
| `--profile fast\|normal\|insane` | tezlik presetlari |
| `--monitor` | oldingi skan bilan diff, faqat yangi topilmalar |
| `--cron "0 9 * * *"` | har kuni avtomatik |
| `--resume` | uzilgan skan'ni davom ettirish |
| `--doctor` / `--update` | tool holati / yangilash |
| `-y` | so'ramasdan ishlasin |

`buz -h` — to'liq ro'yxat.

### Config (API kalitlar)

`buz --init-config` qilib `~/.buz/config` ni to'ldirsangiz recon kuchayadi: Chaos, Shodan, SecurityTrails, VirusTotal, GitHub kalitlari + Telegram bildirishnoma. Kalitsiz ham ishlaydi (crt.sh bepul).

## Natija

Har skan `buz-<target>/` papkasiga yoziladi:

```
report.html        chiroyli hisobot (brauzerda och)
findings.csv/json  barcha topilmalar, severity bo'yicha
report.md          tayyor markdown report
subs/ hosts/ ports/ web/ content/ urls/ vulns/
```

## Muallif

[t.me/j33d1](https://t.me/j33d1)
