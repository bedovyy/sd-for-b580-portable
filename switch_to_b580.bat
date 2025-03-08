@echo off
setlocal

if exist environment.bat (set TARGET=webui) else (set TARGET=comfyui)
echo Found %TARGET%.

echo Install torch for Arc B580...
if %TARGET%==webui (
  call environment.bat
  python system\python\get-pip.py
) else set PATH=%CD%\python_embeded;%PATH%

python -m pip install torch==2.5.1+cxx11.abi torchvision==0.20.1+cxx11.abi torchaudio==2.5.1+cxx11.abi intel-extension-for-pytorch==2.5.10+xpu "numpy<2" --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/bmg/us


echo Download additional dependencies...
mkdir temp
cd temp
curl -L -O https://anaconda.org/conda-forge/libuv/1.50.0/download/win-64/libuv-1.50.0-h2466b09_0.conda
curl -L -O https://anaconda.org/conda-forge/vc14_runtime/14.42.34438/download/win-64/vc14_runtime-14.42.34438-hfd919c2_24.conda
tar xf libuv-1.50.0-h2466b09_0.conda && tar xf pkg-libuv-1.50.0-h2466b09_0.tar.zst
tar xf vc14_runtime-14.42.34438-hfd919c2_24.conda && tar xf pkg-vc14_runtime-14.42.34438-hfd919c2_24.tar.zst
cd ..

if %TARGET%==webui (set LIB_BIN=system\python\Library\bin) else (set LIB_BIN=python_embeded\Library\bin)
copy /y temp\Library\bin\* %LIB_BIN%\


rmdir /s /q temp

echo modify scripts...

if %TARGET%==webui (
  powershell "(Get-Content webui\webui-user.bat) -replace 'COMMANDLINE_ARGS=$', 'COMMANDLINE_ARGS=--use-ipex ' | Set-Content webui\webui-user.bat"
) else (
  powershell "(Get-Content update\update_comfyui_and_python_dependencies.bat) -replace 'torch torchvision torchaudio  --extra-index-url https://download.pytorch.org/whl/cu...'," ^
    "'torch==2.5.1+cxx11.abi torchvision==0.20.1+cxx11.abi torchaudio==2.5.1+cxx11.abi intel-extension-for-pytorch==2.5.10+xpu ""numpy<2""""  --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/bmg/us'" ^
    "| Set-Content update\update_comfyui_and_python_dependencies.bat"
  move run_nvidia_gpu.bat run_arc_b580.bat
)

echo.
echo Finished.
endlocal
pause