# AGENTS.md

## Project

CS16 Platform

## Goal

Modern Counter-Strike 1.6 Server Platform

## Rules

- One feature = One commit
- One module = One folder
- No generated binaries in Git
- Document before implementation
- Security first
- Backward compatibility when possible

## Commit Style

feat:
fix:
refactor:
docs:
test:
chore:

## Branches

main
develop
feature/*
hotfix/*

## Languages

- C/C++
- Pawn (AMXX)
- Python (API)
- TypeScript (Dashboard)

## Architecture

Server
↓
Plugin SDK
↓
REST API
↓
Dashboard