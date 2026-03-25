import Link from 'next/link'
import { GraduationCap, BookOpen, Brain, Target, CheckCircle, Layers, ArrowLeft } from 'lucide-react'
import type { LucideIcon } from 'lucide-react'

const benefits: { icon: LucideIcon; title: string; description: string }[] = [
  {
    icon: BookOpen,
    title: 'Flashcards interactives',
    description: 'Mémorise les notions clés avec des cartes recto-verso',
  },
  {
    icon: Brain,
    title: 'Schémas de synthèse',
    description: 'Visualise et comprends les concepts en un coup d\'oeil',
  },
  {
    icon: Target,
    title: 'Quiz d\'entraînement',
    description: 'Teste tes connaissances et identifie tes lacunes',
  },
  {
    icon: Layers,
    title: '8 matières couvertes',
    description: 'Éco, Compta, Philo, Droit, Maths, Français, Histoire-Géo, Anglais',
  },
  {
    icon: CheckCircle,
    title: 'Programme officiel du Bac',
    description: 'Contenu aligné sur le programme officiel du baccalauréat',
  },
]

interface AuthLayoutProps {
  children: React.ReactNode
  title: string
  subtitle: string
}

export default function AuthLayout({ children, title, subtitle }: AuthLayoutProps) {
  return (
    <div className="flex min-h-screen bg-background">
      {/* Left — Benefits */}
      <div className="hidden lg:flex lg:w-1/2 flex-col justify-center bg-gradient-to-br from-emerald-600 via-teal-700 to-emerald-900 px-12 xl:px-20 relative overflow-hidden">
        {/* Decorative shapes */}
        <div className="absolute top-10 left-10 w-64 h-64 bg-emerald-400 rounded-full opacity-10 blur-3xl" />
        <div className="absolute bottom-20 right-10 w-80 h-80 bg-amber-400 rounded-full opacity-5 blur-3xl" />

        <div className="relative z-10 max-w-lg">
          <Link href="/" className="inline-flex items-center gap-2 mb-8">
            <div className="w-10 h-10 rounded-xl bg-white/10 flex items-center justify-center">
              <GraduationCap className="h-6 w-6 text-white" />
            </div>
            <span className="font-serif text-3xl font-bold text-white">
              BacSuccess
            </span>
          </Link>
          <h1 className="font-serif text-3xl xl:text-4xl font-bold text-white leading-tight mb-4">
            Réussis ton Bac avec des fiches de révision interactives
          </h1>
          <p className="text-emerald-100 text-lg mb-10">
            La plateforme gratuite pour les élèves de Terminale en Afrique de l'Ouest.
          </p>

          <div className="space-y-5">
            {benefits.map((b) => (
              <div key={b.title} className="flex items-start gap-4">
                <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-white/10">
                  <b.icon className="h-5 w-5 text-amber-300" />
                </div>
                <div>
                  <p className="font-semibold text-white">{b.title}</p>
                  <p className="text-sm text-emerald-100/70">{b.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Right — Form */}
      <div className="flex w-full lg:w-1/2 flex-col items-center justify-center px-4 py-12">
        <div className="w-full max-w-md">
          {/* Back to home */}
          <Link
            href="/"
            className="inline-flex items-center gap-1.5 text-sm text-muted hover:text-foreground transition-colors mb-8"
          >
            <ArrowLeft className="w-4 h-4" />
            Retour à l'accueil
          </Link>

          {/* Mobile logo */}
          <div className="mb-8 text-center lg:hidden">
            <div className="inline-flex items-center gap-2">
              <div className="w-9 h-9 rounded-xl bg-primary flex items-center justify-center">
                <GraduationCap className="h-5 w-5 text-white" />
              </div>
              <span className="font-serif text-2xl font-bold text-foreground">
                BacSuccess
              </span>
            </div>
            <p className="mt-2 text-muted">{subtitle}</p>
          </div>

          {/* Desktop heading */}
          <div className="mb-8 hidden lg:block">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              {title}
            </h2>
            <p className="mt-1 text-muted">{subtitle}</p>
          </div>

          {children}
        </div>
      </div>
    </div>
  )
}
