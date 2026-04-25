@echo off
title Git推送助手

echo ===============================================
echo   Git推送助手 代理127.0.0.1:7890
echo ===============================================
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo 错误 当前目录不是Git仓库
    pause
    exit /b 1
)

set http_proxy=http://127.0.0.1:7890
set https_proxy=http://127.0.0.1:7890
echo 代理已设置 http://127.0.0.1:7890
echo.

echo 修改的文件:
git status -s
echo.

set /p commit_msg=请输入更新说明 直接回车则为普通更新: 
if "%commit_msg%"=="" set commit_msg=普通更新
echo.

echo 1/3 添加修改...
git add .
if errorlevel 1 (
    echo 错误 git add失败
    pause
    exit /b 1
)
echo 完成
echo.

echo 2/3 提交...
git commit -m "%commit_msg%"
if errorlevel 1 (
    echo 提示 没有需要提交的更改
)
echo.

echo 3/3 推送...
git push
if errorlevel 1 (
    echo 错误 推送失败 请检查网络或代理
    pause
    exit /b 1
)
echo 完成
echo.

echo ===============================================
echo   推送成功
echo ===============================================
timeout /t 2 >nul