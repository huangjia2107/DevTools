### Git 常用命令

### 项目

1. 克隆远程项目

   ```bash
   # 克隆主分支代码
   $ git clone <项目地址>
   # 克隆指定分支代码
   $ git clone -b <分支名> <项目地址>
   ```

2. 关联本地项目

   ```bash
   # 在项目根目录下执行
   $ git init
   # 与远程仓库同步
   $ git remote add origin <项目地址>
   ```

### 配置

1. 全局仓库

   ```bash
   # 配置全局用户名
   $ git config --global user.name "<User>"
   # 配置全局邮箱
   $ git config --global user.email "<Email>"
   ```

2. 当前仓库

   ```bash
   # 配置当前仓库用户名
   $ git config user.name "<User>"
   # 配置当前仓库邮箱
   $ git config user.email "<Email>"
   ```

3. 配置完成后，可以到项目根目录下的 **.git\config** 文件中确认

   ```ini
   [user]
   	name = <User>
   	email = <Email>
   ```

### SSH

1. 查看（Windows 操作系统下，生成的SSH公钥和密钥都放在 **C:\Users\\<UserName>\\.ssh** 文件夹中）

   ```bash
   $ cd ~/.ssh
   $ ls
   ```

3. 创建

   ```bash
   # 后续要求输入的文件名及密码可以省略，直接回车即可，最终生成 id_rsa 和 id_rsa.pub
   # 如果输入了密码,每次 push 都要输入密码
   $ ssh-keygen -t rsa -C "<注释>"
   ```

4. 将 **id_rsa.pub** 文件的内容设置到 Github 或者 Gitlab 上即可

   ```bash
   # 拷贝内容命令，或通过编辑器也行
   $ clip < ~/.ssh/id_rsa.pub
   ```

### 拉取

1. Pull，比较直接，远程与本地分支直接合并，有冲突的情况下，容易出问题

   ```bash
   #                +---> 本地分支[.git\refs\heads]
   # 远程仓库 ------>|
   #                +---> 跟踪的远程分支[.git\refs\remotes]
   
   # 远程仓库 --> 跟踪的远程分支 --> 本地分支
   $ git pull
   ```

2. Fetch，比较安全，也更符合实际要求，有机会在合并前查看差异

   ```bash
   #                +---> 本地分支[.git\refs\heads]
   # 远程仓库 ------>|
   #                +---> 跟踪的远程分支[.git\refs\remotes]
   
   # 远程仓库 --> 跟踪的远程分支
   $ git fetch origin master
   # 比较本地分支与远程仓库的区别
   $ git log -p master.. origin/master
   # 跟踪的远程分支 --> 本地分支
   $ git merge origin/master
   ```

3. 如果远程分支与本地分支有冲突，在执行上述命令时，有可能遇到如下错误

   ```bash
   error: Your local changes to the following files would be overwritten by merge:
           src/Modules/CASApp.Server/ViewModels/EventListControlViewModel.cs
   Please commit your changes or stash them before you merge.
   Aborting
   Updating 4894473..622db08
   ```

   但暂时不想提交代码，可执行下列步骤进行代码同步

   （1）使用 stash 保存当前工作目录

   ```bash
    $ git stash
   ```

   （2）在执行上述的拉取命令

   （3）恢复工作目录

   ```bash
   # 查看保存的工作目录
   $ git stash list 
   # 恢复并删除 stash 中内容
   $ git stash pop  
   ```

### 提交

1. 状态

   ```bash
   # 查看当前仓库状态
   $ git status
   ```

2. 添加

   ```bash
   # 添加“已追踪且已修改”的文件
   $ git add -u
   # 添加指定项
   $ git add <文件>
   # 添加所有项
   $ git add .
   ```

3. 提交

   ```bash
   # 提交“已追踪”且被添加的项
   $ git commit -m “<注释>”
   ```

4. 推送

   ```bash
   # 推送到远程仓库
   $ git push
   ```

5. 提交记录

   ```bash
   # 查看最新 10 条提交记录，可不指定参数
   $ git log -10
   ```

### 标签

1. 创建

   ```bash
   # 创建本地标签
   $ git tag -a <标签名> -m "<注释>"
   # 推送到远程仓库
   $ git push origin <标签名>
   ```

2. 显示

   ```bash
   $ git tag
   ```
   
3. 重命名

   ```bash
   # 重命名
   $ git tag <新的标签名> <旧的标签名>
   # 删除本地旧标签
   $ git tag -d <旧的标签名>
   # 删除远程仓库中旧标签
   $ git push origin :refs/tags/<旧的标签名>
   # 推送到远程仓库
   $ git push origin --tags
   ```

4. 删除

   ```bash
   # 删除本地标签
   $ git tag -d <标签名>
   # 删除远程仓库中标签
   $ git push origin :refs/tags/<标签名>
   ```

5. 检出

   ```bash
   # 不要在该标签代码上直接修改提交，请使用分支
   $ git checkout <标签名>
   ```

### 分支

1. 查看

   ```bash
   # 显示本地分支
   $ git branch 
   # 显示本地与远程分支
   $ git branch -a
   ```

2. 创建

   ```bash
   # 创建
   $ git branch <分支名>
   # 推动到远程仓库
   $ git push origin <分支名>
   ```

3. 切换

   ```bash
   $ git checkout <分支名>
   ```


4. 合并提交

   ```bash
   # 合并 head 到 <提交 ID> 的提交
   $ git rebase -i <提交 ID>
   # 合并最近的两次提交
   $ git rebase -i HEAD~2
   ```

5. 变基，一般在分支上操作，将主分支代码同步到当前分支，最好先执行第 4 条的合并提交，在变基时有效减少冲突次数

   ```bash
   # 变基
   $ git rebase master
   
   # 解决冲突
   # ...
   
   # 解决冲突后，继续变基
   $ git rebase --continue
   ```

6.  合并

   ```bash
   # 切换到主分支
   $ git checkout master 
   # 拉取最新代码
   $ git pull
   
   #-------------------可选项------------------#
   # 切换到分支
   $ git checkout <分支名>
   
   # 合并分支提交（参考第 4 条）
   # ...
   
   # 变基（参考第 5 条）
   # ...
   
   # 切换到主分支
   $ git checkout master
   #------------------------------------------#
   
   # 将分支代码合并到主分支
   $ git merge <分支名>
   # 推送到远程仓库
   $ git push
   ```

7. 删除

   ```bash
   # 删除本地分支
   $ git branch -d <分支名>
   # 删除远程分支
   $ git push origin --delete <分支名>
   ```

   