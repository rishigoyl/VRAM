#!/bin/bash
cd ~/.config && mkdir notify && cd notify && touch provider-config.yaml
echo "telegram:" >> provider-config.yaml
echo "  - id: \"tel\"" >> provider-config.yaml
echo "    telegram_api_key: \"\"" >> provider-config.yaml
echo "    telegram_chat_id: \"\"" >> provider-config.yaml
echo "    telegram_format: \"{{data}}\"" >> provider-config.yaml
