# ComfyUI & stable-diffusion-webui Converter for Arc B580

A converter enabling the portable release of the Stable Diffusion tool listed below to operate on Intel Arc B580.
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- [stable-diffusion-webui-forge](https://github.com/lllyasviel/stable-diffusion-webui-forge)
- [stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

## How to Use

1. Download portable version of the tool
2. Unzip
3. Copy `switch_to_b580.bat` to where `run*.bat` exists
4. Run `switch_to_b580.bat`

Or simply download converted one from [Releases page](https://github.com/bedovyy/sd-for-b580-portable/releases).

After converting, follow the guide of the tool.
- ComfyUI: https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file#windows-portable
- stable-diffusion-webui-forge: https://github.com/lllyasviel/stable-diffusion-webui-forge?tab=readme-ov-file#installing-forge
- stable-diffusion-webui: https://github.com/AUTOMATIC1111/stable-diffusion-webui?tab=readme-ov-file#installation-on-windows-1011-with-nvidia-gpus-using-release-package


## What it does

- Install torch for Arc B580 (2.5.1+cxx11.abi) on portable python.
- Install libuv and vc14_runtime on portable python.
- Edit some scripts
  - Add `--use-ipex` for stable-diffusion-webui*
  - Modify `update_comfyui_and_python_dependencies.bat` to keep torch for B580 for ComfyUI
  - Rename `run_nvidia_gpu.bat` to `run_arc_b580.bat` for ComfyUI

## Notice

- This batch file uses PowerShell and tested on Win11, but not on Win10.
- Every converted tools have only been tested for basic T2I generation on SDXL.
