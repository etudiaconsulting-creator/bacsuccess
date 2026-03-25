import Link from 'next/link';
import { Check, X } from 'lucide-react';
import ScrollReveal from '@/components/ui/ScrollReveal';

export default function PricingGrid() {
  const plans = [
    {
      name: 'Gratuit',
      price: '0 FCFA',
      description: null,
      included: [
        'Accès aux fiches gratuites',
        'Quiz limités (3/jour)',
        '1 matière',
      ],
      excluded: [
        'Toutes les matières',
        'Quiz illimités',
        'Annales corrigées',
        'Support prioritaire',
      ],
      cta: 'Commencer gratuitement',
      href: '/signup',
      featured: false,
    },
    {
      name: 'Premium',
      price: '2 900 FCFA',
      description: '7 jours d\'essai gratuit',
      included: [
        'Toutes les fiches et matières',
        'Quiz illimités',
        'Flashcards interactives',
        'Annales corrigées',
        'Schémas de synthèse',
        'Accès hors-ligne',
      ],
      excluded: [],
      cta: 'Essayer 7 jours gratuit',
      href: '/signup',
      featured: true,
    },
    {
      name: 'Coaching',
      price: '7 900 FCFA',
      description: null,
      included: [
        'Tout le plan Premium',
        'Coaching personnalisé',
        'Correction d\'exercices',
        'Groupe WhatsApp VIP',
        'Suivi de progression',
      ],
      excluded: [],
      cta: 'Choisir Coaching',
      href: '/signup',
      featured: false,
    },
  ];

  return (
    <section id="tarifs" className="py-20 px-4 bg-gray-50 dark:bg-[#151c28]">
      <div className="max-w-5xl mx-auto">
        <h2 className="font-serif text-3xl sm:text-4xl font-bold text-center mb-4 text-gray-900 dark:text-white">
          Des tarifs simples et accessibles
        </h2>
        <p className="text-muted text-center mb-12 max-w-2xl mx-auto text-gray-600 dark:text-gray-400">
          Commence gratuitement, passe en Premium quand tu es prêt
        </p>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8 mb-12">
          {plans.map((plan, index) => (
            <ScrollReveal
              key={plan.name}
              animation="fade-in-up"
              delay={index * 100}
              className={plan.featured ? 'lg:scale-105' : ''}
            >
              <div
                className={`rounded-2xl bg-white dark:bg-[#1c2333] p-8 border flex flex-col h-full transition-all duration-300 ${
                  plan.featured
                    ? 'border-2 border-emerald-600 dark:border-emerald-500 shadow-xl relative'
                    : 'border border-gray-200 dark:border-gray-700'
                }`}
              >
                {plan.featured && (
                  <div className="absolute -top-4 left-1/2 transform -translate-x-1/2">
                    <span className="bg-amber-400 text-white rounded-full px-4 py-1 text-sm font-bold">
                      Le plus populaire
                    </span>
                  </div>
                )}

                <h3 className="font-serif text-2xl font-bold mb-2 text-gray-900 dark:text-white">
                  {plan.name}
                </h3>

                <div className="mb-2">
                  <span className="text-4xl font-extrabold font-serif text-gray-900 dark:text-white">
                    {plan.price}
                  </span>
                  <span className="text-gray-600 dark:text-gray-400 ml-2">/mois</span>
                </div>

                {plan.description && (
                  <p className="text-sm text-emerald-600 dark:text-emerald-400 mb-6 font-medium">
                    {plan.description}
                  </p>
                )}

                <Link
                  href={plan.href}
                  className={`w-full py-3 px-4 rounded-lg font-bold transition-all duration-300 mb-8 text-center ${
                    plan.featured
                      ? 'bg-emerald-600 dark:bg-emerald-600 text-white hover:bg-emerald-700 dark:hover:bg-emerald-700'
                      : 'border-2 border-emerald-600 dark:border-emerald-500 text-emerald-600 dark:text-emerald-400 hover:bg-emerald-600 dark:hover:bg-emerald-600 hover:text-white'
                  }`}
                >
                  {plan.cta}
                </Link>

                <div className="space-y-3 flex-grow">
                  {plan.included.map((feature) => (
                    <div key={feature} className="flex items-start gap-3">
                      <Check className="w-5 h-5 text-emerald-600 dark:text-emerald-400 flex-shrink-0 mt-0.5" />
                      <span className="text-gray-700 dark:text-gray-300">{feature}</span>
                    </div>
                  ))}

                  {plan.excluded.map((feature) => (
                    <div key={feature} className="flex items-start gap-3 opacity-50">
                      <X className="w-5 h-5 text-gray-400 dark:text-gray-500 flex-shrink-0 mt-0.5" />
                      <span className="text-gray-500 dark:text-gray-400">{feature}</span>
                    </div>
                  ))}
                </div>
              </div>
            </ScrollReveal>
          ))}
        </div>

        <div className="text-center">
          <p className="text-gray-600 dark:text-gray-400 mb-4">Paiement sécurisé par</p>
          <div className="flex flex-wrap justify-center gap-3">
            <span className="rounded-full bg-orange-500 text-white px-3 py-1 text-xs font-bold">
              Orange Money
            </span>
            <span className="rounded-full bg-blue-600 text-white px-3 py-1 text-xs font-bold">
              Wave
            </span>
            <span className="rounded-full bg-yellow-500 text-white px-3 py-1 text-xs font-bold">
              MTN Money
            </span>
            <span className="rounded-full bg-red-500 text-white px-3 py-1 text-xs font-bold">
              Moov Money
            </span>
            <span className="rounded-full bg-indigo-600 text-white px-3 py-1 text-xs font-bold">
              Visa
            </span>
          </div>
        </div>
      </div>
    </section>
  );
}
