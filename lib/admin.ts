// Add admin emails here to grant dashboard access
const ADMIN_EMAILS: string[] = [
  'etudiaconsulting@gmail.com',
  // Add more admin emails as needed
]

export function isAdmin(email: string | undefined): boolean {
  if (!email) return false
  return ADMIN_EMAILS.includes(email.toLowerCase())
}
