@echo off
setlocal enabledelayedexpansion
title HE THONG QUAN TRI AWS CLOUD ALL-IN-ONE
chcp 65001 >nul

:: --- CAU HINH THU MUC CHUA MODULE ---
set "MOD_DIR=modules"

:MAIN_MENU
cls
echo ┌──────────────────────────────────────────────────────┐
echo │      HE THONG QUAN TRI AWS CLOUD ALL-IN-ONE          │
echo │                    Version: 1.1 Final - TTN          │
echo ├──────────────────────────────────────────────────────┤
echo │                                                      │
echo │   [1] AWS Manager: Profiles, Login, Import           │
echo │   [2] VPS Manager : Tao, Xoa, Bat, Tat               │
echo │   [3] PROXY Manager: Tao Proxy SOCKS5                │
echo │   [4] AWS CLI Tools: Cai Dat / Cap Nhat              │
echo │   ---                                                │
echo │   [5] Update System: Kiem Tra Cap Nhat               │
echo │   [0] Thoat Chuong Trinh                             │
echo │                                                      │
echo └──────────────────────────────────────────────────────┘
set /p m_choice=">>> Moi ban chon (1-4): "

if "%m_choice%"=="1" set "TARGET=AWS_MANAGER_PROFILES" & goto EXEC_VIRTUAL
if "%m_choice%"=="2" goto SUB_MENU_VPS
if "%m_choice%"=="3" set "TARGET=TAO_PROXY_AWS" & goto EXEC_VIRTUAL
if "%m_choice%"=="4" set "TARGET=INSTALL_AWS_CLI" & goto EXEC_VIRTUAL
if "%m_choice%"=="5" set "TARGET=UPDATE_SYSTEM" & goto EXEC_VIRTUAL
if "%m_choice%"=="0" exit
goto MAIN_MENU

:: --- MENU CON QUAN LY VPS ---
:SUB_MENU_VPS
cls
echo ╔══════════════════════════════════════════════════════╗
echo ║          MENU CHUC NANG QUAN LY VPS                  ║
echo ╚══════════════════════════════════════════════════════╝
echo    1. Trinh Quan Ly TAO VPS 
echo    2. Trinh Quan Ly XOA VPS 
echo    3. Trinh Quan Ly TAT VPS 
echo    4. Trinh Quan Ly BAT VPS 
echo    5. Thiet Lap (AMI, Subnet, Key, Security Group)
echo    --- 
echo    0. Quay Lai Menu Chinh
echo --------------------------------------------------------
set /p v_choice=">>> Chon chuc nang (1-5): "

if "%v_choice%"=="1" set "TARGET=TAO_VPS_AWS"
if "%v_choice%"=="2" set "TARGET=XOA_VPS_AWS"
if "%v_choice%"=="3" set "TARGET=TAT_VPS_AWS"
if "%v_choice%"=="4" set "TARGET=BAT_VPS_AWS"
if "%v_choice%"=="5" set "TARGET=NEWSETUP_AWS"
if "%v_choice%"=="0" goto MAIN_MENU

:: --- CO CHE THUC THI AO (Sua doi de tim trong thu muc MOD_DIR) ---
:EXEC_VIRTUAL
cls
:: Thiet lap duong dan day du den file module
set "FULL_PATH=%MOD_DIR%\%TARGET%"

:: Kiem tra file co duoi .bat hay chua
if not exist "%FULL_PATH%" (
    if exist "%FULL_PATH%.bat" (set "FULL_PATH=%FULL_PATH%.bat")
)

if exist "%FULL_PATH%" (
    echo [*] Dang khoi tao moi truong thuc thi ao cho: %TARGET%...
    
    :: 1. [COPY] Tao file tam .bat vao thu muc Temp
    set "TMP_BATCH=%TEMP%\aws_exec_%RANDOM%.bat"
    copy /y "%FULL_PATH%" "!TMP_BATCH!" >nul
    
    :: 2. [RUN] Thuc thi file tam
    call "!TMP_BATCH!"
    
    :: 3. [DELETE] Xoa file tam
    if exist "!TMP_BATCH!" del /f /q "!TMP_BATCH!"
    
    :: Quay lai dung Menu noi no duoc goi
    if "%m_choice%"=="2" (goto SUB_MENU_VPS) else (goto MAIN_MENU)
    
) else (
    echo ╔══════════════════════════════════════════════════════╗
    echo ║  [Loi] Khong tim thay module: %TARGET% 
    echo ╚══════════════════════════════════════════════════════╝
    echo [-] Khong tim thay file tai: %FULL_PATH%
    echo [-] Vui long kiem tra thu muc '%MOD_DIR%'.
    pause
    goto MAIN_MENU
)