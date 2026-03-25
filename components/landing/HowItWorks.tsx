import { MousePointerClick, BookOpen, Trophy } from 'lucide-react';
import ScrollReveal from '@/components/ui/ScrollReveal';

export default function HowItWorks() {
  const steps = [
    {
      number: 1,
      icon: MousePointerClick,
      title: 'Choisis ta série',
      description: 'Sélectionne ton pays et ta série (TSE, TSECO, TSS...) pour accéder aux contenus adaptés.',
    },
    {
      number: 2,
      icon: BookOpen,
      title: 'Révise avec les fiches',
      description: 'Parcours les fiches, retourne les flashcards, complète les quiz et maîtrise chaque chapitre.',
    },
    {
      number: 3,
      icon: Trophy,
      title: 'Décroche ton Bac',
      description: 'Avec une préparation complète et régulière, mets toutes les chances de ton côté.',
    },
  ];

  return (
    <section id="comment-ca-marche" className="py-20 px-4 bg-emerald-50 dark:bg-[#151c28]">
      <div className="max-w-6xl mx-auto">
        <ScrollReveal>
          <div className="text-center mb-16">
            <h2 className="font-serif text-3xl sm:text-4xl font-bold text-center mb-4 text-gray-900 dark:text-white">
              Comment ça marche ?
            </h2>
            <p className="text-muted text-center text-gray-600 dark:text-gray-300">
              3 étapes simples pour commencer à réviser
            </p>
          </div>
        </ScrollReveal>

        {/* Desktop: Horizontal Layout */}
        <div className="hidden md:block">
          <div className="relative flex items-stretch justify-between gap-8">
            {/* Connecting Line */}
            <div className="absolute top-8 left-0 right-0 h-1 border-t-2 border-dashed border-emerald-200 dark:border-emerald-900 z-0" />

            {/* Steps */}
            <div className="flex justify-between items-stretch w-full relative z-10 gap-8">
              {steps.map((step, index) => {
                const IconComponent = step.icon;
                return (
                  <div key={step.number} className="flex-1 flex flex-col items-center">
                    {/* Number Circle with Icon */}
                    <div className="relative mb-6">
                      <div className="w-16 h-16 rounded-full bg-emerald-600 text-white flex items-center justify-center text-2xl font-bold shadow-lg">
                        {step.number}
                      </div>
                      <div className="absolute bottom-0 right-0 bg-white dark:bg-gray-800 p-2 rounded-full shadow-md">
                        <IconComponent className="w-5 h-5 text-amber-500" />
                      </div>
                    </div>

                    {/* Content */}
                    <h3 className="font-serif font-bold text-xl text-center mb-3 text-gray-900 dark:text-white">
                      {step.title}
                    </h3>
                    <p className="text-center text-gray-600 dark:text-gray-300 text-sm">
                      {step.description}
                    </p>
                  </div>
                );
              })}
            </div>
          </div>
        </div>

        {/* Mobile: Vertical Layout */}
        <div className="md:hidden">
          <div className="relative flex flex-col items-center gap-0">
            {steps.map((step, index) => {
              const IconComponent = step.icon;
              return (
                <div key={step.number} className="w-full">
                  <div className="flex flex-col items-center mb-8">
                    {/* Vertical Connecting Line */}
                    {index < steps.length - 1 && (
                      <div className="w-1 h-12 border-l-2 border-dashed border-emerald-200 dark:border-emerald-900 mb-8" />
                    )}

                    {/* Number Circle with Icon */}
                    <div className="relative mb-6">
                      <div className="w-16 h-16 rounded-full bg-emerald-600 text-white flex items-center justify-center text-2xl font-bold shadow-lg">
                        {step.number}
                      </div>
                      <div className="absolute bottom-0 right-0 bg-white dark:bg-gray-800 p-2 rounded-full shadow-md">
                        <IconComponent className="w-5 h-5 text-amber-500" />
                      </div>
                    </div>

                    {/* Content */}
                    <h3 className="font-serif font-bold text-xl text-center mb-3 text-gray-900 dark:text-white">
                      {step.title}
                    </h3>
                    <p className="text-center text-gray-600 dark:text-gray-300 text-sm px-4">
                      {step.description}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
