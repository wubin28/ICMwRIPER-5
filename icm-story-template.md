我有一个Kaggle数据集"Agentic AI Performance Dataset 2025”文件 @first-80-rows-agentic_ai_performance_dataset_20250622.xlsx，主要关注AI智能体表现的3个问题：

（1）支持多模态处理（multimodal_capability）的智能体类型（agent_type）在该智能体类型中的占比从大到小排名前三的智能体类型是那三个？；

（2）支持多模态处理（multimodal_capability）的大模型架构（model_architecture）在该大模型架构中的占比从大到小排名前三的大模型架构是哪三个？；

（3）各种智能体处理任务（task_category）各自的智能体表现的公正性（bias detection）的中位数从高到低排名前三的是哪三种智能体处理任务？

我希望将这个数据集可视化，请帮我读取这个Excel文件，用Python进行数据分析，并将相应代码保存到名为“analyze_data.py”的文件中；

然后根据数据分析结果生成一个名为“data-dashboard.html”的HTML格式的综合数据看板。

看板应包含数据可视化设计，并显示你实际处理的数据集总记录数（本数据集共80条数据，请只显示你实际读取并处理的数据行数）。

请使用浅色调设计看板，提供可直接运行的HTML静态代码。

无需提供动态效果或使用静态图片，也不要依赖加载Excel文件来运行HTML代码，确保所有图表在手机浏览器中能完整显示。