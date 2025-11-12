# Troubleshooting Guide

## Common Errors

### 1. Wings: jwt: HMAC key is empty
Cause: The `token_id` and `token` in `/etc/pterodactyl/config.yml` are blank.

Fix:
```bash
sudo nano /etc/pterodactyl/config.yml
sudo systemctl restart wings

