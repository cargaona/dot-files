# OpenClaw VM Secrets

This directory contains sensitive configuration files for the OpenClaw VM.

## Required Files

Create the following files in this directory (they will NOT be committed to git):

### 1. telegram-bot-token
Get this from [@BotFather](https://t.me/BotFather) on Telegram:
1. Send `/newbot` to @BotFather
2. Follow the prompts to name your bot
3. Copy the token and save it to this file

```bash
echo "YOUR_BOT_TOKEN_HERE" > telegram-bot-token
```

### 2. gateway-token
Create a random token for gateway authentication:

```bash
openssl rand -hex 32 > gateway-token
```

Or use any random string:

```bash
echo "your-secure-gateway-token-here" > gateway-token
```

### 3. anthropic-api-key (Optional)
If using Anthropic's Claude API, create this file:

```bash
echo "sk-ant-your-api-key-here" > anthropic-api-key
```

### 4. Get Your Telegram User ID

Send a message to [@userinfobot](https://t.me/userinfobot) and it will reply with your user ID.
Then update `hosts/openclaw-vm/home.nix` with your user ID in the `allowFrom` list.

## File Permissions

These files should only be readable by you:

```bash
chmod 600 telegram-bot-token gateway-token anthropic-api-key
```

## Copying to VM

After building the VM, you'll need to copy these secrets into the VM. See the main README for instructions.
