---
title: "ft_nmap"
date: 2025-01-01
draft: false
description: "A partial reimplementation of the nmap port scanner in C, focusing on understanding network scanning techniques, socket programming, and port detection."
tags: ["C", "Networking", "Security", "Systems"]
categories: ["Systems", "Networking"]
link: "https://github.com/Mohamed-Moumni/ft_nmap"
---

# ft_nmap

A small project that re-implements parts of an `nmap`-style port scanner in C. The goal is educational: to understand how a port scanner works (socket usage, scan strategies, parallelism, parsing IP lists, etc.) and to produce a compact, self-contained scanner executable.

## Overview

In this project, I re-coded a part of the nmap port scanner to deepen my understanding of network scanning techniques, socket programming, and low-level networking concepts.

## Features

- TCP port scanning over a range of ports
- Processing multiple IPs from a file
- Modular architecture with separate components for scanning, parsing, and network mapping
- CLI binary implemented in C

## Technologies Used

- **C** - Core implementation language
- **Socket Programming** - Raw sockets and network communication
- **Make** - Build system

## Repository

[View on GitHub](https://github.com/Mohamed-Moumni/ft_nmap)
