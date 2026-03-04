import { GraduationCap, BookOpen, Brain, Target, CheckCircle, Layers } from 'lucide-react'
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
    description: 'Contenu aligné sur le programme TSECO du Bac malien',
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
      <div className="hidden lg:flex lg:w-1/2 flex-col justify-center bg-primary px-12 xl:px-20">
        <div className="max-w-lg">
          <div className="inline-flex items-center gap-2 mb-6">
            <GraduationCap className="h-10 w-10 text-secondary" />
            <span className="font-serif text-3xl font-bold text-white">
              BacSuccess
            </span>
          </div>
          <h1 className="font-serif text-3xl xl:text-4xl font-bold text-white leading-tight mb-4">
            Réussis ton Bac avec des fiches de révision interactives
          </h1>
          <p className="text-white/70 text-lg mb-10">
            La plateforme gratuite pour les élèves de Terminale au Mali.
          </p>

          <div className="space-y-5">
            {benefits.map((b) => (
              <div key={b.title} className="flex items-start gap-4">
                <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-white/10">
                  <b.icon className="h-5 w-5 text-secondary" />
                </div>
                <div>
                  <p className="font-semibold text-white">{b.title}</p>
                  <p className="text-sm text-white/60">{b.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Right — Form */}
      <div className="flex w-full lg:w-1/2 flex-col items-center justify-center px-4 py-12">
        <div className="w-full max-w-md">
          {/* Mobile logo */}
          <div className="mb-8 text-center lg:hidden">
            <div className="inline-flex items-center gap-2">
              <GraduationCap className="h-8 w-8 text-secondary" />
              <span className="font-serif text-2xl font-bold text-primary">
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
