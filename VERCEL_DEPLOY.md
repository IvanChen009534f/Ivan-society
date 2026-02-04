# Vercel 部署详细指南

## 方法一：使用 Vercel CLI 部署（最简单）

### 步骤 1：安装 Vercel CLI
```bash
npm install -g vercel
```

### 步骤 2：登录 Vercel
```bash
vercel login
```
- 会打开浏览器窗口
- 使用 GitHub/GitLab/Bitbucket 账号登录
- 或邮箱注册新账号

### 步骤 3：进入项目目录
```bash
cd /mnt/okcomputer/output/app
```

### 步骤 4：部署
```bash
# 首次部署（交互式）
vercel

# 后续部署到生产环境
vercel --prod
```

### 部署时的交互提示：
```
? Set up and deploy "~/shanben-society"? [Y/n]  → 输入 Y
? Which scope do you want to deploy to? [your-username]  → 按回车
? Link to existing project? [y/N]  → 输入 N（首次部署）
? What's your project name? [shanben-society]  → 按回车或输入自定义名称
```

### 步骤 5：等待部署完成
部署成功后，会显示类似：
```
🔍  Inspect: https://vercel.com/your-username/shanben-society/xxxxx
✅  Production: https://shanben-society.vercel.app
```

---

## 方法二：通过 GitHub 部署（推荐，可持续集成）

### 步骤 1：创建 GitHub 仓库

**方式 A：命令行创建**
```bash
cd /mnt/okcomputer/output/app

# 初始化 git
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit"

# 在 GitHub 上创建仓库后，关联并推送
git remote add origin https://github.com/YOUR_USERNAME/shanben-society.git
git branch -M main
git push -u origin main
```

**方式 B：网页创建**
1. 访问 https://github.com/new
2. 输入仓库名：`shanben-society`
3. 选择 Public 或 Private
4. 点击 "Create repository"
5. 按页面提示上传代码

### 步骤 2：在 Vercel 中导入

1. 访问 https://vercel.com/new
2. 点击 "Import Git Repository"
3. 选择您的 `shanben-society` 仓库
4. 点击 "Import"

### 步骤 3：配置构建设置

| 配置项 | 值 |
|--------|-----|
| Framework Preset | Vite |
| Build Command | `npm run build` |
| Output Directory | `dist` |
| Install Command | `npm install` |

### 步骤 4：点击 Deploy

等待部署完成，约 1-2 分钟。

---

## 方法三：直接拖拽上传（最快，无需 Git）

### 步骤 1：准备代码
```bash
cd /mnt/okcomputer/output

# 打包代码（排除 node_modules）
zip -r shanben-society.zip app/ -x "*/node_modules/*" "*/.git/*"
```

### 步骤 2：Vercel 网页上传

1. 访问 https://vercel.com/new
2. 在 "Import Git Repository" 下方找到 "Upload" 选项
3. 或访问 https://vercel.com/new/upload
4. 将 `shanben-society.zip` 拖拽到页面
5. 等待上传和解压

### 步骤 3：配置项目

填写项目信息：
- **Project Name**: `shanben-society`
- **Framework**: 选择 "Vite"
- **Root Directory**: `app`

点击 "Deploy"

---

## 部署后配置

### 1. 查看部署状态
访问 Vercel 控制台：https://vercel.com/dashboard

### 2. 获取域名
部署成功后，您的网站地址类似：
```
https://shanben-society.vercel.app
```

### 3. 测试 API
访问以下地址测试后端：
```
https://shanben-society.vercel.app/api/health
```

应该返回：
```json
{
  "status": "ok",
  "aiCharacters": 15,
  "users": 0,
  "forums": 9
}
```

---

## 常见问题

### Q1: 部署失败，提示 "Build Failed"
**解决**：
1. 检查 `vercel.json` 配置是否正确
2. 确保 `package.json` 中有 `build` 脚本
3. 查看 Vercel 控制台的具体错误日志

### Q2: API 返回 404
**解决**：
检查 `vercel.json` 中的路由配置：
```json
{
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "/api/index.js"
    },
    {
      "src": "/(.*)",
      "dest": "/dist/$1"
    }
  ]
}
```

### Q3: 前端显示 "服务离线"
**解决**：
1. 检查 API 地址配置
2. 确保后端代码已正确部署
3. 访问 `/api/health` 测试后端

---

## 更新部署

### 使用 CLI 更新
```bash
cd /mnt/okcomputer/output/app
vercel --prod
```

### 使用 GitHub 更新
```bash
git add .
git commit -m "Update"
git push
```
Vercel 会自动重新部署。

---

## 自定义域名（可选）

1. 在 Vercel 控制台点击您的项目
2. 点击 "Settings" → "Domains"
3. 输入您的域名
4. 按提示配置 DNS

---

## 需要帮助？

如果遇到问题，请提供：
1. 错误截图
2. Vercel 控制台中的错误日志
3. 您的操作步骤
