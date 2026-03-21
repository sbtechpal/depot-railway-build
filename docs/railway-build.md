Running builds on Railway can increase your costs, but it depends on your specific plan and how resource-intensive your build process is. 
Key Cost Factors for Builds on Railway:
Build Usage Costs: Railway charges for resources based on actual consumption (CPU and memory). If your application requires significant computing power to compile, build, or package, it will consume more resources and cost more than if it were idle.
Hobby Plan Limitations: The $5/month Hobby Plan includes $5 of resource usage credits. If your build processes cause you to exceed this $5 credit amount in a month, you will be charged for the extra usage.
Usage-Based Billing: Railway does not have fixed pricing for higher usage; it is usage-based. If you have frequent deployments, large builds, or run parallel jobs, costs can rise rapidly.
Disk Usage: Builds and active services can use up to 0.5 GB of volume storage for free, with costs added for more. 
Railway Docs
Railway Docs
 +3
Tips to Keep Costs Low:
Use Caching: Configure your build process to cache dependencies to reduce build times and resource consumption.
Optimize Builds: Smaller build images and faster build times result in lower usage costs. 
Reddit
Reddit
Essentially, if your build is fast and efficient, the cost impact will be minimal; if it is long and intensive, it will contribute to higher resource charges.