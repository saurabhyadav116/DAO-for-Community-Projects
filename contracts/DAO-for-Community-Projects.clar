;; DAO for Community Projects
;; Members can propose projects and vote on them

(define-constant err-not-member (err u100))
(define-constant err-proposal-exists (err u101))
(define-constant err-proposal-not-found (err u102))
(define-constant err-already-voted (err u103))

;; DAO members (using a map instead of list for easier membership checking)
(define-map members principal bool)

;; Initialize contract deployer as first member
(map-set members tx-sender true)

;; Proposals: map proposal id (uint) to proposal data
(define-map proposals uint
  {
    proposer: principal,
    description: (string-ascii 256),
    votes-for: uint,
    votes-against: uint,
    executed: bool
  }
)

;; Track votes: map (proposal id, voter principal) to bool (true if voted)
(define-map votes (tuple (proposal-id uint) (voter principal)) bool)

;; Proposal counter
(define-data-var proposal-counter uint u0)

;; Helper function to check if caller is a member
(define-private (is-member (user principal))
  (default-to false (map-get? members user))
)

;; Add a new member (could be restricted to existing members or admin)
(define-public (add-member (new-member principal))
  (begin
    (asserts! (is-member tx-sender) err-not-member)
    (map-set members new-member true)
    (ok true)
  )
)

;; Submit a project proposal (only members)
(define-public (submit-proposal (description (string-ascii 256)))
  (begin
    (asserts! (is-member tx-sender) err-not-member)
    (let ((new-id (+ (var-get proposal-counter) u1)))
      (var-set proposal-counter new-id)
      (map-set proposals new-id {
        proposer: tx-sender,
        description: description,
        votes-for: u0,
        votes-against: u0,
        executed: false
      })
      (ok new-id)
    )
  )
)

;; Vote on a proposal (for or against)
(define-public (vote (proposal-id uint) (support bool))
  (begin
    (asserts! (is-member tx-sender) err-not-member)
    (asserts! (is-none (map-get? votes {proposal-id: proposal-id, voter: tx-sender})) err-already-voted)
    (let ((proposal (map-get? proposals proposal-id)))
      (match proposal
        p
        (begin
          (map-set votes {proposal-id: proposal-id, voter: tx-sender} true)
          (if support
            (map-set proposals proposal-id {
              proposer: (get proposer p),
              description: (get description p),
              votes-for: (+ (get votes-for p) u1),
              votes-against: (get votes-against p),
              executed: (get executed p)
            })
            (map-set proposals proposal-id {
              proposer: (get proposer p),
              description: (get description p),
              votes-for: (get votes-for p),
              votes-against: (+ (get votes-against p) u1),
              executed: (get executed p)
            })
          )
          (ok true)
        )
        err-proposal-not-found
      )
    )
  )
)

;; Get proposal details
(define-read-only (get-proposal (proposal-id uint))
  (map-get? proposals proposal-id)
)

;; Check if user is a member
(define-read-only (check-membership (user principal))
  (is-member user)
)