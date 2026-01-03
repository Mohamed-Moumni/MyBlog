---
title: "ft_ping"
date: 2025-01-01
draft: false
description: "A reimplementation of the ping command in C, exploring ICMP protocol, raw sockets, and network diagnostics. Built to understand network programming fundamentals."
tags: ["C", "Networking", "ICMP", "Systems", "Low-Level"]
categories: ["Systems", "Networking"]
link: "https://github.com/Mohamed-Moumni/ft_ping"
---

# ft_ping

A complete reimplementation of the `ping` command in C, built to understand how network diagnostics work at a low level. This project dives deep into the ICMP protocol, raw sockets, and the fundamentals of network programming.

## Overview

The `ping` command is a network administration utility used to test the reachability of a host on a network. Reimplementing it from scratch provides invaluable insights into how network protocols operate, how packets are constructed and sent, and how the operating system handles network communication.

## Features

- ICMP Echo Request/Reply implementation
- Raw socket programming
- Hostname resolution using `getaddrinfo()`
- Round-trip time (RTT) calculation
- Packet statistics (sent, received, loss percentage)
- Signal handling for timing and interruption

## How It Works

The implementation is broken down into four main components:

1. **Argument Parsing** - Handles command-line arguments and validates input
2. **Socket Setup** - Creates raw sockets and resolves hostnames to IP addresses
3. **Ping Loop** - Sends ICMP Echo Requests and receives Echo Replies at regular intervals
4. **Statistics Output** - Displays comprehensive ping statistics including RTT, TTL, and packet loss

The project uses the ICMP protocol (Internet Control Message Protocol) at the Network Layer, crafting ICMP packets with proper headers including type, code, checksum, identifier, and sequence number.

## Technologies Used

- **C** - Core implementation language
- **Raw Sockets** - Low-level network access
- **ICMP Protocol** - Internet Control Message Protocol
- **Signal Handling** - For timing and process control

## Related Blog Post

I wrote a detailed blog post about this project: [Reimplementation of the Ping Command](/posts/reimplementation-ping-command-in-c/)

## Repository

[View on GitHub](https://github.com/Mohamed-Moumni/ft_ping)

