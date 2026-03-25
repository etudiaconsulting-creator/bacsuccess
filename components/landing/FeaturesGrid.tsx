import { BookOpen, Brain, Layers, GitBranch, FileText, MessageCircle } from 'lucide-react'
import ScrollReveal from '@/components/ui/ScrollReveal'

const features = [
  {
    icon: BookOpen,
    title: 'Fiches de révision',
    description: 'Des fiches complètes et interactives pour chaque matière, basées sur le programme officiel.',
    bgColor: 'bg-emerald-100',
    iconColor: 'text-emerald-600',
  },
  {
    icon: Brain,
    title: 'Quiz interactifs',
    description: 'Teste tes connaissances avec des quiz corrigés et des explications détaillées.',
    bgColor: 'bg-amber-100',
    iconColor: 'text-amber-600',
  },
  {
    icon: Layers,
    title: 'Flashcards',
    description: 'Mémorise l\'essentiel grâce aux flashcards interactives à retourner.',
    bgColor: 'bg-purple-100',
    iconColor: 'text-purple-600',
  },
  {
    icon: GitBranch,
    title: 'Schémas de synthèse',
    description: 'Visualise les concepts clés avec des schémas et mind maps.',
    bgColor: 'bg-blue-100',
    iconColor: 'text-blue-600',
  },
  {
    icon: FileText,
    title: 'Annales du Bac',
    description: 'Entraîne-toi sur les vrais sujets du Bac des années précédentes.',
    bgColor: 'bg-orange-100',
    iconColor: 'text-orange-600',
  },
  {
    icon: MessageCircle,
    title: 'Bot WhatsApp',
    description: 'Révise directement depuis WhatsApp, même sans data.',
    bgColor: 'bg-green-100',
    iconColor: 'text-green-600',
  },
]

export default function FeaturesGrid() {
  return (
    <section className="py-20 px-4 sm:px-6 lg:px-8 bg-white dark:bg-[#0f1419]">
      <div className="max-w-6xl mx-auto">
        {/* Section header */}
        <div className="text-center mb-16">
          <h2 className="font-serif text-3xl sm:text-4xl font-bold text-gray-900 mb-4">
            Tout ce qu'il te faut pour réussir
          </h2>
          <p className="text-lg text-gray-600">
            Des outils conçus spécialement pour les élèves africains
          </p>
        </div>

        {/* Features grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {features.map((feature, index) => {
            const Icon = feature.icon

            return (
              <ScrollReveal key={index} delay={index * 100}>
                <div className="rounded-2xl border border-gray-200 bg-white p-6 hover:shadow-lg hover:scale-[1.02] transition-all duration-300 h-full">
                  {/* Icon */}
                  <div className={`${feature.bgColor} w-12 h-12 rounded-xl flex items-center justify-center mb-4`}>
                    <Icon className={`w-6 h-6 ${feature.iconColor}`} />
                  </div>

                  {/* Title */}
                  <h3 className="font-serif font-bold text-lg text-gray-900 mb-2">
                    {feature.title}
                  </h3>

                  {/* Description */}
                  <p className="text-gray-600 text-sm">
                    {feature.description}
                  </p>
                </div>
              </ScrollReveal>
            )
          })}
        </div>
      </div>
    </section>
  )
}
