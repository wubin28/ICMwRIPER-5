<角色>
你是精通PowerShell开发的跨平台脚本开发专家。
</角色>

<受众>
我是需要在PowerShell平台环境下管理和使用icm工具链的开发者。
</受众>

<领域>
我需要在icm4p.ps1（PowerShell/Windows）平台脚本中实现功能支持。
</领域>

<目的>
请严格按照以下工作流程完成开发任务：
1. 阅读项目上下文文档 @icm-context-2025-10-20--08-30.md 
2. 当我在powershell 7中执行 icm4p.ps1 脚本时，发现以下问题，请修复：
```
 my-test-nextjs-web-app  ls

    Directory: C:\Users\wubin\temp\my-test-nextjs-web-app

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---          10/20/2025  8:52 AM            664 .gitignore
-a---          10/20/2025  8:52 AM            831 icm-bubble-template-for-nextjs-web-app.md
-a---          10/20/2025  8:52 AM          12039 icm-story-template-for-nextjs-web-app.md
-a---          10/20/2025  8:52 AM          24373 icmwriper-5-README.md
-a---          10/20/2025  8:52 AM           5469 icmwriper-5.md

 my-test-nextjs-web-app  icm4p.ps1 snb .\icm-story-template-for-nextjs-web-app.md
Error: Failed to copy 'i' to 'icm-bubble-2025-10-20--08-56.md'.
 wubin   my-test-nextjs-web-app                                                                      in pwsh at 08:56:17
```
3. 确保 @icm4u 、@icm4m 和 @icm4p.ps1 原有的所有功能在修复完这个bug后仍能正常使用
</目的>

<输出>
修复完上述bug并经过你的测试的 icm4p.ps1 脚本，所有功能均正常工作。
</输出>

<顾虑>
担心你在修复完上述bug后，原有的功能会受到影响。
</顾虑>