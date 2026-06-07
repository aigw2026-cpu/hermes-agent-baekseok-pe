#!/bin/bash
# Hermes Agent v0.15.2 설치 스크립트
# 백석대 특수체육 자동화 패키지
# 사용법: bash install-hermes.sh

set -e

echo "========================================"
echo " Hermes Agent v0.15.2 설치 시작"
echo " 백석대 특수체육 자동화 패키지"
echo "========================================"

# OS 감지
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="windows"
fi

echo "[1/5] OS 감지: $OS"

# Node.js 확인
if ! command -v node &> /dev/null; then
    echo "[ERROR] Node.js가 설치되어 있지 않습니다."
    echo "설치: https://nodejs.org/en/download/"
    exit 1
fi

NODE_VERSION=$(node --version)
echo "[2/5] Node.js 확인: $NODE_VERSION"

# Hermes Agent 설치
echo "[3/5] Hermes Agent 설치 중..."
npm install -g @nousresearch/hermes-agent@latest 2>/dev/null || \
  npm install -g hermes-agent@latest 2>/dev/null || \
  pip install hermes-agent 2>/dev/null || \
  { echo "[WARN] npm 설치 실패. pip 시도..."; pip3 install hermes-agent; }

# 설정 디렉토리 생성
echo "[4/5] 설정 디렉토리 생성..."
mkdir -p ~/.hermes/skills
mkdir -p ~/.hermes/memory

# 설정 파일 복사
if [ -f "config/hermes-config.yaml" ]; then
    cp config/hermes-config.yaml ~/.hermes/config.yaml
    echo "  ✓ hermes-config.yaml 적용 완료"
fi

if [ -f "skills/special-pe-verifier.yaml" ]; then
    cp skills/special-pe-verifier.yaml ~/.hermes/skills/
    echo "  ✓ special-pe-verifier.yaml 스킬 등록 완료"
fi

# 설치 확인
echo "[5/5] 설치 확인..."
if command -v hermes &> /dev/null; then
    HERMES_VERSION=$(hermes --version 2>/dev/null || echo "installed")
    echo "  ✓ Hermes Agent 설치 완료: $HERMES_VERSION"
else
    echo "  [WARN] hermes 명령어를 찾을 수 없습니다. PATH를 확인하세요."
fi

echo ""
echo "========================================"
echo " 설치 완료! 다음 단계를 실행하세요:"
echo "========================================"
echo ""
echo "  1. 메모리 등록:  bash scripts/memory-setup.sh"
echo "  2. 실행 테스트:  hermes chat"
echo "  3. MCP 포함:     hermes chat --tools"
echo "  4. 병렬 처리:    hermes batch run --workers 4"
echo ""
echo "  n8n: n8n/harness-v4-hermes.json import"
echo ""
