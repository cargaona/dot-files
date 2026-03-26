#!/usr/bin/env bash
# OpenClaw VM Setup Script
# Run this after first boot to configure secrets and start the gateway

set -e

echo "===================================="
echo "OpenClaw VM Setup"
echo "===================================="
echo ""

SECRETS_DIR="$HOME/.secrets"
mkdir -p "$SECRETS_DIR"
chmod 700 "$SECRETS_DIR"

echo "Step 1: Telegram Bot Token"
echo "--------------------------"
echo "Get your bot token from @BotFather on Telegram"
echo "1. Open Telegram and search for @BotFather"
echo "2. Send /newbot and follow the prompts"
echo "3. Copy the token (looks like: 123456:ABC-DEF1234ghIkl-zyx57W2v1u123ew11)"
echo ""
read -p "Enter your Telegram bot token: " TELEGRAM_TOKEN

if [ -z "$TELEGRAM_TOKEN" ]; then
  echo "Error: Token cannot be empty"
  exit 1
fi

echo "$TELEGRAM_TOKEN" > "$SECRETS_DIR/telegram-bot-token"
chmod 600 "$SECRETS_DIR/telegram-bot-token"
echo "✓ Saved to $SECRETS_DIR/telegram-bot-token"
echo ""

echo "Step 2: Gateway Token"
echo "---------------------"
echo "Generating secure gateway authentication token..."
GATEWAY_TOKEN=$(openssl rand -hex 32)
echo "$GATEWAY_TOKEN" > "$SECRETS_DIR/gateway-token"
chmod 600 "$SECRETS_DIR/gateway-token"
echo "✓ Saved to $SECRETS_DIR/gateway-token"
echo ""

echo "Step 3: Anthropic API Key (Optional)"
echo "------------------------------------"
read -p "Do you have an Anthropic API key? (y/n): " HAS_ANTHROPIC

if [ "$HAS_ANTHROPIC" = "y" ] || [ "$HAS_ANTHROPIC" = "Y" ]; then
  read -p "Enter your Anthropic API key: " ANTHROPIC_KEY
  if [ -n "$ANTHROPIC_KEY" ]; then
    echo "ANTHROPIC_API_KEY=$ANTHROPIC_KEY" > "$SECRETS_DIR/env"
    chmod 600 "$SECRETS_DIR/env"
    echo "✓ Saved to $SECRETS_DIR/env"
  fi
fi
echo ""

echo "Step 4: Verify Configuration"
echo "----------------------------"
echo "Checking your Telegram user ID..."
echo ""
echo "To find your Telegram user ID:"
echo "1. Open Telegram and search for @userinfobot"
echo "2. Send /start to the bot"
echo "3. It will reply with your user ID (a number like 123456789)"
echo ""
read -p "What is your Telegram user ID? (just to verify): " USER_ID
echo ""

if [ -z "$USER_ID" ]; then
  echo "⚠ Warning: You didn't provide a user ID"
  echo "Make sure to update allowFrom in the home.nix configuration"
else
  echo "Your user ID: $USER_ID"
  echo "⚠ IMPORTANT: Verify this matches the allowFrom list in:"
  echo "   /nix/store/.../home.nix (allowFrom = [ $USER_ID ];)"
fi
echo ""

echo "Step 5: Enable and Start Gateway Service"
echo "----------------------------------------"
read -p "Start the OpenClaw gateway now? (y/n): " START_NOW

if [ "$START_NOW" = "y" ] || [ "$START_NOW" = "Y" ]; then
  echo "Enabling and starting openclaw-gateway service..."
  systemctl --user enable openclaw-gateway
  systemctl --user start openclaw-gateway
  
  sleep 2
  
  echo ""
  echo "Service status:"
  systemctl --user status openclaw-gateway --no-pager || true
  echo ""
  
  echo "To view logs:"
  echo "  journalctl --user -u openclaw-gateway -f"
else
  echo "To manually start later, run:"
  echo "  systemctl --user enable --now openclaw-gateway"
fi

echo ""
echo "===================================="
echo "Setup Complete!"
echo "===================================="
echo ""
echo "Your OpenClaw VM is configured."
echo ""
echo "Test your bot:"
echo "1. Open Telegram"
echo "2. Search for your bot (the username you set with @BotFather)"
echo "3. Send: /status"
echo ""
echo "If the bot doesn't respond, check logs:"
echo "  journalctl --user -u openclaw-gateway -f"
echo ""
