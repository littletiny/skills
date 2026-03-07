#!/bin/bash
# 安装 git hooks，实现 submodule 更新后自动同步上层仓库

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
HOOKS_DIR="$ROOT_DIR/hooks"

echo "Installing git hooks..."

# 1. 上层仓库 hook: 当执行 submodule update 后自动 add
cat > "$ROOT_DIR/.git/hooks/post-checkout" << 'EOF'
#!/bin/bash
# post-checkout hook: submodule 更新后自动添加到上层仓库

# 检查是否有 submodule 变化
if git diff --quiet HEAD -- SHECR 2>/dev/null; then
    exit 0
fi

# 获取变更信息
SUBMODULE_NAME="SHECR"
NEW_COMMIT=$(git rev-parse --short HEAD:SHECR 2>/dev/null || echo "unknown")

echo ""
echo "[Hook] Detected $SUBMODULE_NAME update to $NEW_COMMIT"
echo "[Hook] Auto-staging $SUBMODULE_NAME..."

git add "$SUBMODULE_NAME"

# 检查是否在合并或 rebase 中，避免冲突
if [ -d "$(git rev-parse --git-dir)/rebase-merge" ] || [ -f "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
    echo "[Hook] Skipping auto-commit during rebase/merge"
    exit 0
fi

# 自动提交
git commit -m "chore: auto-update $SUBMODULE_NAME to $NEW_COMMIT" --no-verify 2>/dev/null || true

echo "[Hook] Done."
EOF

chmod +x "$ROOT_DIR/.git/hooks/post-checkout"

# 2. 上层仓库 hook: merge 后检查
cat > "$ROOT_DIR/.git/hooks/post-merge" << 'EOF'
#!/bin/bash
# post-merge hook: merge 后检查 submodule 是否需要更新

if git diff --quiet HEAD -- SHECR 2>/dev/null; then
    exit 0
fi

SUBMODULE_NAME="SHECR"
NEW_COMMIT=$(git rev-parse --short HEAD:SHECR 2>/dev/null || echo "unknown")

echo ""
echo "[Hook] Detected $SUBMODULE_NAME update to $NEW_COMMIT"
echo "[Hook] Auto-staging $SUBMODULE_NAME..."

git add "$SUBMODULE_NAME"
git commit -m "chore: auto-update $SUBMODULE_NAME to $NEW_COMMIT" --no-verify 2>/dev/null || true
EOF

chmod +x "$ROOT_DIR/.git/hooks/post-merge"

# 3. 上层仓库 hook: 当手动 add 后自动 commit
cat > "$ROOT_DIR/.git/hooks/post-rewrite" << 'EOF'
#!/bin/bash
# post-rewrite hook: rebase 等操作后检查

if git diff --quiet HEAD -- SHECR 2>/dev/null; then
    exit 0
fi

SUBMODULE_NAME="SHECR"
NEW_COMMIT=$(git rev-parse --short HEAD:SHECR 2>/dev/null || echo "unknown")

echo ""
echo "[Hook] Detected $SUBMODULE_NAME update to $NEW_COMMIT"
echo "[Hook] Auto-staging $SUBMODULE_NAME..."

git add "$SUBMODULE_NAME"
EOF

chmod +x "$ROOT_DIR/.git/hooks/post-rewrite"

# 4. SHECR submodule hook: 在 submodule 内 pull 后触发上层更新
SHECR_GIT_DIR="$ROOT_DIR/SHECR/.git"
if [ -d "$SHECR_GIT_DIR" ]; then
    cat > "$SHECR_GIT_DIR/hooks/post-merge" << EOF
#!/bin/bash
# post-merge hook in submodule: trigger parent repo update

echo ""
echo "[Hook] SHECR updated, notifying parent repo..."

cd "$ROOT_DIR" || exit 1

# 获取新的 commit hash
NEW_COMMIT=\$(git -C SHECR rev-parse --short HEAD)

echo "[Hook] New commit: \$NEW_COMMIT"
echo "[Hook] Auto-staging SHECR in parent repo..."

git add SHECR
git commit -m "chore: auto-update SHECR to \$NEW_COMMIT" --no-verify 2>/dev/null || echo "[Hook] Nothing to commit or already staged"

echo "[Hook] Parent repo updated."
EOF

    chmod +x "$SHECR_GIT_DIR/hooks/post-merge"
    
    # post-checkout hook for pulls
    cat > "$SHECR_GIT_DIR/hooks/post-checkout" << EOF
#!/bin/bash
# post-checkout hook in submodule: trigger parent repo update

echo ""
echo "[Hook] SHECR checkout detected, updating parent repo..."

cd "$ROOT_DIR" || exit 1

NEW_COMMIT=\$(git -C SHECR rev-parse --short HEAD 2>/dev/null || echo "unknown")

git add SHECR 2>/dev/null || true
git commit -m "chore: auto-update SHECR to \$NEW_COMMIT" --no-verify 2>/dev/null || true
EOF

    chmod +x "$SHECR_GIT_DIR/hooks/post-checkout"
    
    echo "✓ Installed hooks for SHECR submodule"
fi

echo "✓ Hooks installed successfully!"
echo ""
echo "Hooks installed:"
echo "  - .git/hooks/post-checkout (parent)"
echo "  - .git/hooks/post-merge (parent)"
echo "  - .git/hooks/post-rewrite (parent)"
echo "  - SHECR/.git/hooks/post-merge (submodule)"
echo "  - SHECR/.git/hooks/post-checkout (submodule)"
echo ""
echo "Note: Hooks are local only and won't be committed."
echo "Other team members need to run: ./hooks/install-hooks.sh"
