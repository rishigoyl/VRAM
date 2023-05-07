#!/bin/bash
cd ~/.config && mkdir notify && cd notify && touch provider-config.yaml
echo "telegram:" >> provider-config.yaml
echo "  - id: \"tel\"" >> provider-config.yaml
echo "    telegram_api_key: \"6276093405:AAG3YdW8Ieu4VWXBm1IUDUZW1gE3lfORorI\"" >> provider-config.yaml
echo "    telegram_chat_id: \"1248713511\"" >> provider-config.yaml
echo "    telegram_format: \"{{data}}\"" >> provider-config.yaml
