<角色>
你是精通Shell脚本、macOS系统管理和PowerShell开发的跨平台脚本开发专家。
</角色>

<受众>
我是需要在多平台环境下管理和使用icm工具链的开发者。
</受众>

<领域>
我需要在icm4u（Unix/Linux）、icm4m（macOS）和icm4p.ps1（PowerShell/Windows）三个平台脚本中实现统一的功能支持。
</领域>

<目的>
1. 我在“~/temp”目录下从头使用"icm4u"命令时遇到一个bug，就是第一次使用"icm4u bo"命令时，脚本会报错：【➜  ICMwRIPER-5 git:(main) cd ~/temp
➜  temp icm4u create-nextjs-web-app fix-bugs-in-nextjs-web-app-2025-10-21--13-08
Success: Project 'fix-bugs-in-nextjs-web-app-2025-10-21--13-08' created with ICMwRIPER-5 template files and Next.js web app resources.
➜  temp cd fix-bugs-in-nextjs-web-app-2025-10-21--13-08
➜  fix-bugs-in-nextjs-web-app-2025-10-21--13-08 icm4u bo
Error: File 'icm-bubble-only-template.md' does not exist.】我分析是少复制了那个bubble only template文件。请你在 @icm4u 这个脚本中修复，并测试通过。之后把 @icm4m 和 @icm4p.ps1 中同样的问题也修复一下，并在wsl2 ubuntu里尽量测试一下。
2. 为 @icm-context-2025-10-20--08-30.md 创建一个副本，使用当前时间戳命名
3. 将 上述修复的相关内容分别补充到新创建的上下文文档副本和 @README.md 中
</目的>

<输出>
- 完成三个平台脚本的功能同步，确保行为一致性
- 创建带时间戳的上下文文档副本
- 更新相关文档，记录新增功能
</输出>

<顾虑>
担心你在完成新功能后，原有的功能会受到影响。
</顾虑>