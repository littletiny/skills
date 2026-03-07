# Git Hooks

自动同步 submodule 更新到上层仓库的 hooks。

## 安装

```bash
./hooks/install-hooks.sh
```

## 效果

安装后，当 **SHECR** submodule 有更新时，会自动提交到上层仓库：

### 场景 1: 在 submodule 内更新
```bash
cd SHECR
git pull origin master  # 自动触发上层 git add + commit
```

### 场景 2: 在上层更新 submodule
```bash
git submodule update --remote SHECR  # 自动触发 git commit
```

## 自动提交信息格式

```
chore: auto-update SHECR to <short-commit-hash>
```

## 注意事项

- Hooks 是**本地配置**，不会随 `git clone` 自动安装
- 团队成员需要各自运行 `./hooks/install-hooks.sh`
- 在 rebase/merge 冲突时会跳过自动提交，避免干扰

## 卸载

删除对应的 hook 文件即可：

```bash
rm .git/hooks/post-checkout
rm .git/hooks/post-merge
rm .git/hooks/post-rewrite
rm SHECR/.git/hooks/post-merge
rm SHECR/.git/hooks/post-checkout
```
