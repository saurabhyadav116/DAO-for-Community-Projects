# DAO for Community Projects

## Project Description

This smart contract implements a **Decentralized Autonomous Organization (DAO)** designed to support **community-led projects**. Members of the DAO can:

- Submit project proposals.
- Vote for or against these proposals.
- Make decisions through equal voting rights.

The contract ensures **transparency**, **immutability**, and **equal participation**, making it ideal for grassroots organizations, local communities, or small groups looking for collaborative governance tools.

---

## Key Features

- ✅ **Member-based Access Control**  
  Only registered members can participate in the governance process (i.e., submit proposals and vote).

- 🗳️ **Proposal System**  
  Members can create proposals describing community projects. Each proposal includes:
  - `proposer`: Who submitted it.
  - `description`: A brief about the project (up to 256 ASCII characters).
  - `votes-for` and `votes-against`: Tally of current votes.
  - `executed`: Marks whether a proposal has been carried out.

- 📥 **Voting Mechanism**  
  Members can cast one vote per proposal (`support: true` or `false`). Double voting is prevented.

- 🔐 **Immutable Voting History**  
  Voting records are stored using a composite key of `(proposal-id, voter)`, ensuring accountability and preventing double voting.

- 👥 **Initial Membership Bootstrap**  
  The contract deployer is automatically registered as the first member.

---

## Error Codes

| Error Constant           | Code   | Description                                   |
|--------------------------|--------|-----------------------------------------------|
| `err-not-member`         | `100`  | Caller is not a registered DAO member         |
| `err-proposal-exists`    | `101`  | Proposal already exists (reserved, not used)  |
| `err-proposal-not-found` | `102`  | Proposal does not exist                       |
| `err-already-voted`      | `103`  | Member has already voted on this proposal     |

---

## Project Vision

To empower community-driven initiatives by **decentralizing governance and funding decisions**, ensuring fairness and transparency in project selection and resource allocation. By eliminating hierarchical control, this DAO promotes inclusivity and shared ownership over community outcomes.

---

## Future Scope

The contract establishes a strong foundation but can evolve significantly. Future enhancements include:

### 🔧 Member Management
- Add the ability to **remove members**, not just add them.
- Introduce **role-based access control** (e.g., admin privileges).

### 🧾 Proposal Execution & Governance
- **Execution logic**: Add `execute-proposal` function to implement or reject passed proposals.
- **Quorum requirements**: Ensure a minimum number of voters before a proposal can pass.
- **Time-based voting windows** to allow fair participation.

### 💰 Treasury Integration
- Integrate a **treasury system** for project funding.
- Enable **fund disbursement** only for approved and executed proposals.
- Introduce **spending limits and auditing functions**.

### 🪙 Token-Weighted Voting (Governance v2)
- Instead of equal voting, introduce **voting power proportional to token holdings**.
- Allow delegation and staking mechanisms.

### 🌐 Frontend Integration
- Build a **web interface** for submitting proposals and voting.
- Show live proposal statistics and voter transparency.

---

## Technical Stack

- **Language**: Clarity (Stacks blockchain smart contract language)
- **Platform**: Stacks blockchain (built on Bitcoin)
- **Design Pattern**: Role-based access, DAO governance pattern

---

## How to Interact

1. Deploy the contract using a Clarity-compatible development environment (e.g., [Clarinet](https://docs.stacks.co/clarity/clarinet-cli)).
2. Use provided public functions to:
   - `add-member` (admin/members only)
   - `submit-proposal`
   - `vote`
   - `get-proposal`
   - `check-membership`

## Contract Address
ST1NH271TBKBCRHQP37SY9MEAJGQ45Q802NR7MKA9.DAO-for-Community-Projects
![alt text](image.png)
