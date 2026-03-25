import { ChevronDown } from 'lucide-react';

export default function FAQ() {
  const faqs = [
    {
      question: 'Est-ce que BacSuccess est gratuit ?',
      answer:
        'Oui ! Tu peux commencer à utiliser BacSuccess gratuitement. Le plan gratuit te donne accès à une sélection de fiches et quiz. Pour un accès complet à tous les contenus et fonctionnalités, tu peux passer au plan Premium à 2 900 FCFA/mois.',
    },
    {
      question: 'Pour quels pays est disponible BacSuccess ?',
      answer:
        'BacSuccess est actuellement disponible pour le Mali, avec le Sénégal et la Côte d\'Ivoire en cours de préparation. Nos contenus sont basés sur les programmes officiels de chaque pays.',
    },
    {
      question: 'Comment je peux payer ?',
      answer:
        'Tu peux payer via Orange Money, Wave, MTN Money, Moov Money ou par carte Visa. Le paiement est simple et sécurisé.',
    },
    {
      question: 'Est-ce que je peux réviser hors-ligne ?',
      answer:
        'Avec le plan Premium, tu peux télécharger les fiches et y accéder même sans connexion internet. Idéal quand tu n\'as pas de data !',
    },
    {
      question: 'Les contenus suivent-ils le programme officiel ?',
      answer:
        'Absolument ! Tous nos contenus sont créés par des enseignants qualifiés et suivent rigoureusement le programme officiel du baccalauréat de chaque pays.',
    },
    {
      question: 'Comment fonctionne le bot WhatsApp ?',
      answer:
        'Envoie simplement un message à notre bot WhatsApp et reçois des fiches de révision, des quiz et des rappels directement dans ta conversation. Pas besoin de data, ça marche même en 2G !',
    },
  ];

  return (
    <section className="py-20 px-4 bg-white dark:bg-[#0f1419]">
      <div className="max-w-3xl mx-auto">
        <h2 className="font-serif text-3xl sm:text-4xl font-bold text-center mb-12 text-gray-900 dark:text-white">
          Questions fréquentes
        </h2>

        <div className="space-y-4">
          {faqs.map((faq, index) => (
            <details
              key={index}
              className="border border-gray-200 dark:border-gray-700 rounded-xl overflow-hidden group"
            >
              <summary className="flex items-center justify-between p-5 font-serif font-semibold text-lg cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800 transition text-gray-900 dark:text-white">
                <span>{faq.question}</span>
                <ChevronDown className="faq-chevron w-5 h-5 text-gray-600 dark:text-gray-400 flex-shrink-0" />
              </summary>
              <div className="faq-content px-5 pb-5 text-gray-600 dark:text-gray-400 border-t border-gray-200 dark:border-gray-700">
                {faq.answer}
              </div>
            </details>
          ))}
        </div>
      </div>
    </section>
  );
}
