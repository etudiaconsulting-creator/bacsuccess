import Link from 'next/link';
import { Shield } from 'lucide-react';

export default function FinalCTA() {
  return (
    <section className="py-20 px-4">
      <div className="max-w-6xl mx-auto">
        <div className="rounded-3xl bg-gradient-to-br from-emerald-600 via-teal-700 to-emerald-800 text-white p-12 sm:p-16 text-center relative overflow-hidden">
          {/* Decorative floating shapes */}
          <div className="absolute top-10 left-10 w-32 h-32 rounded-full bg-white opacity-5 blur-3xl"></div>
          <div className="absolute bottom-10 right-10 w-40 h-40 rounded-full bg-white opacity-5 blur-3xl"></div>
          <div className="absolute top-1/2 right-20 w-24 h-24 rounded-full bg-white opacity-5 blur-2xl"></div>

          <div className="relative z-10">
            <h2 className="font-serif text-3xl sm:text-4xl lg:text-5xl font-extrabold mb-6">
              Prêt à réussir ton Bac ?
            </h2>

            <p className="text-emerald-100 text-lg max-w-xl mx-auto mb-10">
              Rejoins les milliers d'élèves qui préparent leur baccalauréat avec BacSuccess. C'est gratuit !
            </p>

            <Link
              href="/signup"
              className="inline-block bg-white text-emerald-700 font-bold rounded-full px-10 py-4 text-lg shadow-lg hover:shadow-xl hover:scale-105 transition-all duration-300"
            >
              Commencer gratuitement
            </Link>

            <div className="flex items-center justify-center gap-2 mt-8 text-emerald-50">
              <Shield className="w-5 h-5" />
              <span className="text-sm">Gratuit, sans carte bancaire</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
