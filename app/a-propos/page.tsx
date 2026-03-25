import type { Metadata } from 'next'
import { Mail, ExternalLink, GraduationCap } from 'lucide-react'
import Header from '@/components/layout/AuthHeader'
import Footer from '@/components/layout/Footer'
import TeamPhoto from '@/components/ui/TeamPhoto'

export const metadata: Metadata = {
  title: 'À propos - BacSuccess',
  description:
    "Découvrez l'équipe derrière BacSuccess. Notre mission : démocratiser l'accès à des révisions de qualité pour les lycéens africains.",
}

const TEAM = [
  {
    name: 'Mohamed Boullayat',
    role: 'Co-fondateur',
    initials: 'MB',
    // TODO: Remplacer par la vraie photo (public/team/mohamed.jpg)
    photo: '/team/mohamed.jpg',
    description:
      "Diplômé de Paris Dauphine-PSL en Économie et Gestion de la Santé. Ancien formateur chez McDonald's et directeur adjoint en EHPAD. Passionné par l'éducation et la technologie au service de l'Afrique.",
    linkedin: 'https://www.linkedin.com/in/mohamed-boullayat/',
  },
  {
    name: 'Marouf Gackou',
    role: 'Co-fondateur',
    initials: 'MG',
    // TODO: Remplacer par la vraie photo (public/team/marouf.jpg)
    photo: '/team/marouf.jpg',
    description:
      "Diplômé de Sorbonne Paris Nord en Management des Organisations Sanitaires et Sociales. Originaire du Mali, il a travaillé à Bamako en recherche clinique avant de se consacrer à l'accès à l'éducation en Afrique.",
    linkedin: 'https://www.linkedin.com/in/marouf-gackou-9624231a4/',
  },
]

export default function AProposPage() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      {/* Hero */}
      <section className="bg-primary dark:bg-[#0d2818] px-4 py-16 text-center text-white sm:py-20">
        <GraduationCap className="mx-auto h-12 w-12 text-secondary" />
        <h1 className="mt-4 font-serif text-3xl font-bold sm:text-4xl">
          Notre mission
        </h1>
        <p className="mx-auto mt-4 max-w-2xl text-lg text-gray-200">
          Démocratiser l&apos;accès à des révisions de qualité pour les lycéens africains
        </p>
      </section>

      <main className="flex-1">
        <div className="mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
          {/* Pourquoi BacSuccess */}
          <section className="py-12 sm:py-16">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              Pourquoi BacSuccess ?
            </h2>
            <p className="mt-4 leading-relaxed text-muted">
              En 2024, seulement 27% des candidats ont réussi le baccalauréat au Mali.
              Ce chiffre reflète un manque criant d&apos;outils de révision adaptés et
              accessibles. BacSuccess est né de la conviction que chaque lycéen mérite
              des outils de révision modernes, gratuits et adaptés à son programme,
              quel que soit son accès à Internet ou ses moyens financiers.
            </p>
          </section>

          {/* L'équipe */}
          <section className="pb-12 sm:pb-16">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              L&apos;équipe
            </h2>
            <div className="mt-8 grid grid-cols-1 gap-8 sm:grid-cols-2">
              {TEAM.map((member) => (
                <div
                  key={member.name}
                  className="flex flex-col items-center rounded-xl border border-gray-200 bg-white p-8 shadow-sm"
                >
                  <TeamPhoto
                    name={member.name}
                    initials={member.initials}
                    photo={member.photo}
                  />
                  <h3 className="mt-4 text-lg font-bold text-foreground">
                    {member.name}
                  </h3>
                  <p className="text-sm font-medium text-secondary">
                    {member.role}
                  </p>
                  <p className="mt-3 text-center text-sm leading-relaxed text-muted">
                    {member.description}
                  </p>
                  <a
                    href={member.linkedin}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="mt-4 inline-flex items-center gap-1.5 rounded-lg bg-primary px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-primary-light"
                  >
                    LinkedIn
                    <ExternalLink className="h-3.5 w-3.5" />
                  </a>
                </div>
              ))}
            </div>
          </section>

          {/* Contact */}
          <section className="pb-12 sm:pb-16">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              Contact
            </h2>
            <div className="mt-6 flex flex-col items-center rounded-xl border border-gray-200 bg-white p-8 shadow-sm sm:flex-row sm:gap-6">
              <div className="flex h-14 w-14 flex-shrink-0 items-center justify-center rounded-full bg-secondary/20">
                <Mail className="h-6 w-6 text-secondary" />
              </div>
              <div className="mt-4 text-center sm:mt-0 sm:text-left">
                <p className="text-sm text-muted">
                  Une question, un partenariat ou un retour ?
                </p>
                <a
                  href="mailto:etudiaconsulting@gmail.com"
                  className="mt-1 block font-medium text-foreground hover:text-primary"
                >
                  etudiaconsulting@gmail.com
                </a>
              </div>
              <div className="mt-4 sm:ml-auto sm:mt-0">
                <a
                  href="mailto:etudiaconsulting@gmail.com"
                  className="inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 font-semibold text-white transition-colors hover:bg-primary-light"
                >
                  <Mail className="h-4 w-4" />
                  Nous contacter par email
                </a>
              </div>
            </div>
          </section>
        </div>
      </main>

      <Footer />
    </div>
  )
}
