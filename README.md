# Hermes Agent v0.15.2 — 백석대 특수체육 자동화 패키지

> **2026-06-02 업데이트 기준** | NousResearch Hermes Agent  
> **계정**: aigw2026@gmail.com | **환경**: WSL2 / macOS / Windows

---

## 📦 패키지 구성

```
hermes-setup/
├── scripts/
│   ├── install-hermes.sh        ← Step 1: 설치 스크립트
│   └── memory-setup.sh          ← Step 3: 메모리 등록
├── config/
│   └── hermes-config.yaml       ← Step 2: 설정 파일 (MCP 7개 + workers=4)
├── skills/
│   └── special-pe-verifier.yaml ← 학회지 검증 스킬 (용어·p값·SEM·PRISMA)
└── n8n/
    └── harness-v4-hermes.json   ← n8n 워크플로우 (import용)
```

---

## 🚀 빠른 시작 (WSL2 / macOS / Linux)

```bash
# 1단계: 설치
bash scripts/install-hermes.sh

# 2단계: 메모리 등록 (한 번만)
bash scripts/memory-setup.sh

# 3단계: 실행 확인
hermes chat --tools
```

### Windows (PowerShell)

```powershell
# 설정 파일 복사
Copy-Item hermes-config.yaml $env:LOCALAPPDATA\hermes\hermes-agent\config.yaml

# 스킬 복사
Copy-Item skills\special-pe-verifier.yaml $env:USERPROFILE\.hermes\skills\
```

---

## ⚡ 병렬 처리 (workers=4)

```bash
# 논문 4편 동시 검증
hermes batch run \
  --skill special-pe-verifier \
  --input ./papers/*.pdf \
  --workers 4 \
  --output ./verified/

# API 서버 실행 (n8n 연동)
hermes api --port 8765
```

---

## 🔗 n8n 워크플로우 연동

1. n8n 접속: https://aigw2026.app.n8n.cloud
2. Workflows → **Import from file**
3. `n8n/harness-v4-hermes.json` 선택
4. Hermes API URL 설정: `http://localhost:8765`

### n8n 트리거 스케줄 (내일 오전 10시 자동 실행)
- **Cron**: `0 10 * * *` (매일 오전 10시)
- **Workflow**: Hermes Agent 설치 확인 → 병렬 검증 실행 → 결과 저장

---

## 🧠 MCP 도구 연결 (7개)

| MCP 도구 | 기능 |
|---------|------|
| Google Drive | 논문_투고전검토 폴더 접근 |
| PubMed | 병렬 학술 검색 (3채널) |
| n8n Webhook | 자동화 트리거 |
| Google Calendar | 스케줄 관리 |
| GitHub | 코드 저장/업데이트 |
| Memory | 학회지 규칙 영구 저장 |
| File System | 로컬 파일 처리 |

---

## 📋 주요 명령어

| 명령 | 설명 |
|------|------|
| `hermes chat` | 대화 시작 |
| `hermes chat --tools` | MCP 도구 포함 |
| `hermes skill list` | 등록된 스킬 확인 |
| `hermes memory list` | 메모리 목록 |
| `hermes batch run` | 병렬 배치 처리 |
| `hermes api --port 8765` | API 서버 (n8n 연동) |
| `hermes update` | 최신 버전 업데이트 |

---

## 📊 병렬 PubMed 검증 결과 (v0.15.2)

지적장애 신체활동 메타분석 선행연구 확인:
- **Hedges' g = 0.897** (p < .01) — 교수님 논문 g=0.82와 직접 비교 가능
- RE-AIM 프레임워크 기반 분석
- 3채널 동시 검색으로 수집 시간 67% 단축

---

## 🗓️ 스케줄 (Google Calendar 등록 완료)

- **내일 오전 10:00** — Hermes Agent 설치 및 실행 (2026-06-09)
- n8n 트리거: 매일 오전 10:00 자동 실행

---

## 📁 Claude Projects 연동

이 레포지토리는 Claude Projects와 연동하여 새 프로젝트 시작 시 자동으로 에르메스 에이전트 설치 지식을 활용합니다.

- **프로젝트 지식**: 설치 순서, MCP 설정, 학회지 검증 스킬 전체 내용 포함
- **신규 프로젝트**: 이 README를 Claude Project에 추가하여 즉시 활용 가능

---

*백석대학교 특수체육학과 | 논문 자동화 시스템 v0.15.2*
