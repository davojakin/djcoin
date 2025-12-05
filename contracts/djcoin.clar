;; title: djcoin
;; version: 1.0.0
;; summary: A simple fungible token (FT) called DJCoin
;; description: |
;;   DJCoin is a basic fungible token implemented in Clarity. It supports
;;   minting by the contract owner and token transfers between users.

;; -----------------------------------------------------------------------------
;; token definitions
;; -----------------------------------------------------------------------------

(define-fungible-token djcoin)

;; -----------------------------------------------------------------------------
;; constants
;; -----------------------------------------------------------------------------

(define-constant ERR_UNAUTHORIZED (err u100))
(define-constant ERR_INSUFFICIENT_BALANCE (err u101))

;; -----------------------------------------------------------------------------
;; data vars
;; -----------------------------------------------------------------------------

;; The contract owner is the address that deployed this contract
(define-data-var contract-owner principal tx-sender)

;; Track the total supply of DJCoin that has been minted
(define-data-var total-supply uint u0)

;; -----------------------------------------------------------------------------
;; public functions
;; -----------------------------------------------------------------------------

;; Mint new DJCoin to a recipient.
;; - Only the contract owner can mint.
;; - Increases the total supply by `amount`.
(define-public (mint (amount uint) (recipient principal))
  (if (is-eq tx-sender (var-get contract-owner))
      (begin
        (try! (ft-mint? djcoin amount recipient))
        (var-set total-supply (+ (var-get total-supply) amount))
        (ok amount))
      ERR_UNAUTHORIZED))

;; Transfer DJCoin from `sender` to `recipient`.
;; - The tx-sender must be the same as `sender`.
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (if (is-eq tx-sender sender)
      (ft-transfer? djcoin amount sender recipient)
      ERR_UNAUTHORIZED))

;; -----------------------------------------------------------------------------
;; read-only functions
;; -----------------------------------------------------------------------------

;; Get the DJCoin balance of an account.
(define-read-only (get-balance (account principal))
  (ft-get-balance djcoin account))

;; Get the total supply that has been minted.
(define-read-only (get-total-supply)
  (var-get total-supply))

;; Get the contract owner.
(define-read-only (get-owner)
  (var-get contract-owner))

;; -----------------------------------------------------------------------------
;; private helpers
;; -----------------------------------------------------------------------------

;; No private helpers are defined yet. Add any internal helpers here if needed.
