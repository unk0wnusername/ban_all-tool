@echo off
setlocal

rem choose python executable: prefer "python", fallback to "py"
set "PY=python"
where python >nul 2>&1 || (where py >nul 2>&1 && set "PY=py")

%PY% --version >nul 2>&1
if errorlevel 1 (
  echo Python not found. Install Python 3.8+ and ensure "python" or "py" is on PATH.
  exit /b 1
)

if exist .venv (
  rmdir /s /q .venv
)

%PY% -m venv .venv

call .venv\Scripts\activate.bat

python -m pip install --upgrade pip
python -m pip install PyQt6 discord.py

if not exist main.py (
  echo main.py not found in current directory.
  exit /b 1
)

python main.py
endlocal
