'use client'

import { useState } from 'react'
import Link from 'next/link'
import { GraduationCap, Menu, X } from 'lucide-react'
import ThemeToggle from '@/components/ui/ThemeToggle'
import UserMenu from '@/components/layout/UserMenu'

const navLinks = [
  { href: '#comment-ca-marche', label: 'Comment ça marche' },
  { href: '#tarifs', label: 'Tarifs' },
  { href: '/a-propos', label: 'À propos' },
]

interface HeaderProps {
  userEmail?: string
}

export default function Header({ userEmail }: HeaderProps = {}) {
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

  return (
    <header className="sticky top-0 z-50 bg-white/80 dark:bg-[#0f1419]/90 backdrop-blur-lg border-b border-gray-200 dark:border-gray-800">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-4 py-3 sm:px-6 lg:px-8">
        {/* Logo */}
        <Link href="/" className="flex items-center gap-2">
          <div className="w-9 h-9 rounded-xl bg-primary flex items-center justify-center">
            <GraduationCap className="h-5 w-5 text-white" />
          </div>
          <span className="font-serif text-xl font-bold text-foreground">
            BacSuccess
          </span>
          <span className="rounded-full bg-secondary/20 text-secondary px-2 py-0.5 text-xs font-bold">
            Beta
          </span>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden md:flex items-center gap-6">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="text-sm font-medium text-muted hover:text-foreground transition-colors"
            >
              {link.label}
            </Link>
          ))}
        </nav>

        {/* Desktop Actions */}
        <div className="hidden md:flex items-center gap-3">
          <ThemeToggle />
          {userEmail ? (
            <UserMenu email={userEmail} />
          ) : (
            <>
              <Link
                href="/login"
                className="text-sm font-medium text-muted hover:text-foreground transition-colors"
              >
                Connexion
              </Link>
              <Link
                href="/signup"
                className="bg-primary hover:bg-primary-dark text-white font-semibold text-sm rounded-full px-5 py-2.5 transition-colors"
              >
                Commencer
              </Link>
            </>
          )}
        </div>

        {/* Mobile: Theme toggle + Hamburger */}
        <div className="flex md:hidden items-center gap-2">
          <ThemeToggle />
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="p-2 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
            aria-label="Menu"
          >
            {mobileMenuOpen ? (
              <X className="h-6 w-6 text-foreground" />
            ) : (
              <Menu className="h-6 w-6 text-foreground" />
            )}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      {mobileMenuOpen && (
        <div className="md:hidden border-t border-gray-200 dark:border-gray-800 bg-white dark:bg-[#0f1419] px-4 py-4">
          <nav className="flex flex-col gap-3">
            {navLinks.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                onClick={() => setMobileMenuOpen(false)}
                className="text-base font-medium text-muted hover:text-foreground py-2 transition-colors"
              >
                {link.label}
              </Link>
            ))}
            <hr className="border-gray-200 dark:border-gray-800 my-2" />
            <Link
              href="/login"
              onClick={() => setMobileMenuOpen(false)}
              className="text-base font-medium text-muted hover:text-foreground py-2 transition-colors"
            >
              Connexion
            </Link>
            <Link
              href="/signup"
              onClick={() => setMobileMenuOpen(false)}
              className="bg-primary hover:bg-primary-dark text-white font-semibold text-center rounded-full px-5 py-3 transition-colors"
            >
              Commencer gratuitement
            </Link>
          </nav>
        </div>
      )}
    </header>
  )
}
