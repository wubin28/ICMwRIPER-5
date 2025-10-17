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
请先阅读 @icm-context-2025-10-17--14-22.md 以了解上下文，然后完成下面的需求。我发现 @README.md 文件中“**Segment 3: Create command wrapper**”这一条及其相关内容其实没有用处，可以从 @README.md 和 @icm-context-2025-10-17--14-22.md（如果有的话） 中删除。请你遵循 @icmwriper-5.md 所制定的规则完成上述需求。另外，请在 @README.md 文件相关位置添加以注意事项：如果icm4p.ps1将来改名，假设改为“icm4p-new-name.ps1”，那么可以运行以下脚本来实现全局调用的改名：【$userScriptsPath = "$env:USERPROFILE\Documents\PowerShell\Scripts"
Copy-Item icm4p-new-name.ps1 $userScriptsPath\】。
</目的>

<输出>
- 完成三个平台脚本的功能同步，确保行为一致性
- 创建带时间戳的上下文文档副本
- 更新相关文档，记录新增功能
</输出>

<顾虑>
担心你在完成新功能后，原有的功能会受到影响。如果你需要运行sudo命令，担心因为需要我输入密码而中断操作。此时可以停下来，提示我手工完成sudo命令，再继续。
</顾虑>