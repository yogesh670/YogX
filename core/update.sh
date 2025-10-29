#!/usr/bin/env bash
echo "🔄 Updating YogX..."
cd ~/YogX
git pull origin main
bash core/yogx.sh
echo "✅ YogX Updated Successfully!"