'use client';

import { Users, BookOpen, CheckCircle, Star } from 'lucide-react';
import CountUp from '@/components/ui/CountUp';
import ScrollReveal from '@/components/ui/ScrollReveal';

export default function SocialProof() {
  const stats = [
    {
      icon: Users,
      value: 2500,
      label: 'élèves inscrits',
      suffix: '+',
    },
    {
      icon: BookOpen,
      value: 500,
      label: 'fiches disponibles',
      suffix: '+',
    },
    {
      icon: CheckCircle,
      value: 10000,
      label: 'quiz complétés',
      suffix: '+',
    },
  ];

  const testimonials = [
    {
      quote:
        'Grâce à BacSuccess, j\'ai pu réviser toutes mes matières efficacement. Les fiches sont claires et les quiz m\'ont beaucoup aidé.',
      author: 'Aminata D.',
      serie: 'TSE',
      country: 'Mali',
      flag: '🇲🇱',
    },
    {
      quote:
        'Le bot WhatsApp est génial ! Je révise dans le bus, même quand j\'ai pas de wifi.',
      author: 'Moussa K.',
      serie: 'TSECO',
      country: 'Sénégal',
      flag: '🇸🇳',
    },
    {
      quote:
        'Les flashcards m\'ont permis de mémoriser les formules de maths facilement. Je recommande à tous les candidats !',
      author: 'Fatou S.',
      serie: 'TSS',
      country: 'Côte d\'Ivoire',
      flag: '🇨🇮',
    },
  ];

  return (
    <section className="py-20 px-4 bg-white dark:bg-gray-900">
      <div className="max-w-6xl mx-auto">
        {/* Stats Section */}
        <ScrollReveal>
          <div className="mb-20">
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-8">
              {stats.map((stat, index) => {
                const IconComponent = stat.icon;
                return (
                  <div key={index} className="flex flex-col items-center text-center">
                    <IconComponent className="w-10 h-10 text-emerald-600 dark:text-emerald-400 mb-4" />
                    <div className="font-serif text-4xl sm:text-5xl font-bold text-gray-900 dark:text-white mb-2">
                      <CountUp
                        end={stat.value}
                        suffix={stat.suffix}
                        duration={2500}
                      />
                    </div>
                    <p className="text-gray-600 dark:text-gray-300 text-sm font-medium">
                      {stat.label}
                    </p>
                  </div>
                );
              })}
            </div>
          </div>
        </ScrollReveal>

        {/* Testimonials Section */}
        <ScrollReveal>
          <div>
            <h2 className="font-serif text-3xl sm:text-4xl font-bold text-center mb-4 text-gray-900 dark:text-white">
              Ce que disent nos élèves
            </h2>
            <p className="text-center text-gray-600 dark:text-gray-300 mb-12 max-w-2xl mx-auto">
              Des milliers d'étudiants nous font confiance pour leur préparation au Bac
            </p>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {testimonials.map((testimonial, index) => (
                <div
                  key={index}
                  className="rounded-2xl bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 p-6 shadow-sm hover:shadow-md transition-shadow"
                >
                  {/* Star Rating */}
                  <div className="flex gap-1 mb-4">
                    {Array.from({ length: 5 }).map((_, i) => (
                      <Star
                        key={i}
                        className="w-4 h-4 fill-amber-400 text-amber-400"
                      />
                    ))}
                  </div>

                  {/* Quote */}
                  <p className="italic text-gray-700 dark:text-gray-300 mb-6 text-sm leading-relaxed">
                    "{testimonial.quote}"
                  </p>

                  {/* Author Info */}
                  <div className="border-t border-gray-200 dark:border-gray-700 pt-4">
                    <p className="font-semibold text-gray-900 dark:text-white text-sm">
                      {testimonial.author}
                    </p>
                    <p className="text-xs text-gray-600 dark:text-gray-400">
                      {testimonial.serie}, {testimonial.country} {testimonial.flag}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </ScrollReveal>
      </div>
    </section>
  );
}
