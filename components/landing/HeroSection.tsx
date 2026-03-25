import Link from 'next/link'
import { Star, ArrowRight, Users } from 'lucide-react'

export default function HeroSection() {
  return (
    <section className="relative min-h-screen bg-gradient-to-br from-emerald-600 via-teal-700 to-emerald-900 overflow-hidden flex items-center justify-center pt-20 pb-10">
      {/* Decorative floating shapes */}
      <div className="absolute top-10 left-10 w-72 h-72 bg-emerald-400 rounded-full opacity-10 blur-3xl" />
      <div className="absolute bottom-20 right-5 w-96 h-96 bg-orange-400 rounded-full opacity-5 blur-3xl" />
      <div className="absolute top-1/2 right-1/4 w-80 h-80 bg-amber-400 rounded-full opacity-10 blur-3xl" />

      <div className="relative z-10 max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 w-full">
        {/* Badge */}
        <div className="flex justify-center mb-8">
          <div className="inline-flex items-center gap-2 bg-white/10 backdrop-blur border border-white/20 rounded-full px-4 py-2">
            <Star className="w-4 h-4 text-amber-300 fill-amber-300" />
            <span className="text-sm font-medium text-white">Plateforme #1 de révision du Bac</span>
          </div>
        </div>

        {/* Main content */}
        <div className="text-center mb-12">
          <h1 className="font-serif text-4xl sm:text-5xl lg:text-6xl font-extrabold text-white leading-tight mb-6">
            Réussis ton Bac avec des fiches, quiz et exercices
          </h1>
          <p className="text-lg text-emerald-100 max-w-2xl mx-auto mb-8">
            Rejoins des milliers d'élèves au Mali, Sénégal et Côte d'Ivoire qui préparent leur baccalauréat avec BacSuccess.
          </p>

          {/* CTA Buttons */}
          <div className="flex flex-col sm:flex-row gap-4 justify-center mb-8">
            <Link
              href="/signup"
              className="inline-flex items-center justify-center gap-2 bg-white text-emerald-700 font-bold rounded-full px-8 py-4 text-lg shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300"
            >
              Commence gratuitement
              <ArrowRight className="w-5 h-5" />
            </Link>
            <Link
              href="#comment-ca-marche"
              className="inline-flex items-center justify-center border-2 border-white/30 text-white rounded-full px-8 py-4 hover:bg-white/10 transition-all duration-300"
            >
              Voir comment ça marche
            </Link>
          </div>

          {/* Social proof */}
          <div className="flex items-center justify-center gap-2 text-emerald-100">
            <Users className="w-5 h-5" />
            <span className="text-sm">Rejoins les 2 500+ élèves qui révisent déjà</span>
          </div>
        </div>

        {/* Phone mockup with flashcard preview */}
        <div className="flex justify-center mt-16">
          <div className="rounded-3xl border-4 border-white/20 bg-white/10 backdrop-blur aspect-[9/16] w-[220px] overflow-hidden shadow-2xl">
            {/* Mini flashcards inside phone */}
            <div className="h-full flex flex-col items-center justify-center p-4 gap-3">
              {/* Card 1 */}
              <div
                className="w-full bg-gradient-to-br from-emerald-50 to-teal-50 rounded-xl p-3 border border-emerald-200 shadow-md transform -rotate-3 transition-transform"
              >
                <p className="text-xs font-serif font-bold text-emerald-900 mb-2">Photosynthèse</p>
                <p className="text-[10px] text-emerald-700">
                  Processus de transformation de la lumière...
                </p>
              </div>

              {/* Card 2 */}
              <div
                className="w-full bg-gradient-to-br from-amber-50 to-orange-50 rounded-xl p-3 border border-amber-200 shadow-md transform rotate-2 transition-transform"
              >
                <p className="text-xs font-serif font-bold text-amber-900 mb-2">Équation</p>
                <p className="text-[10px] text-amber-700">
                  2x + 5 = 15, donc x = ?
                </p>
              </div>

              {/* Card 3 */}
              <div
                className="w-full bg-gradient-to-br from-purple-50 to-pink-50 rounded-xl p-3 border border-purple-200 shadow-md transform -rotate-1 transition-transform"
              >
                <p className="text-xs font-serif font-bold text-purple-900 mb-2">Histoire</p>
                <p className="text-[10px] text-purple-700">
                  L'indépendance du Mali en...
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}
