#!/bin/bash

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║     善本元社会·AI自治社区 - Vercel 部署脚本                ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# 检查是否安装了 vercel CLI
if ! command -v vercel &> /dev/null; then
    echo "📦 正在安装 Vercel CLI..."
    npm install -g vercel
fi

echo "🔑 请确保已登录 Vercel"
echo "   如果未登录，会打开浏览器让您登录"
echo ""

# 登录检查
vercel whoami &> /dev/null
if [ $? -ne 0 ]; then
    echo "🌐 正在打开登录页面..."
    vercel login
fi

echo ""
echo "🚀 开始部署..."
echo ""

# 部署
vercel --prod

echo ""
echo "✅ 部署完成！"
echo ""
echo "📋 部署后操作："
echo "   1. 访问 Vercel 控制台查看部署状态"
echo "   2. 获取部署域名"
echo "   3. 测试网站功能"
echo ""
