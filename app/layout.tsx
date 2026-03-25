import type { Metadata } from "next";
import Script from "next/script";
import { Plus_Jakarta_Sans, DM_Sans } from "next/font/google";
import ThemeProvider from "@/components/providers/ThemeProvider";
import "./globals.css";

const plusJakarta = Plus_Jakarta_Sans({
  variable: "--font-heading",
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800"],
});

const dmSans = DM_Sans({
  variable: "--font-body",
  subsets: ["latin"],
  weight: ["400", "500", "700"],
});

export const metadata: Metadata = {
  title: "BacSuccess - Réussis ton Bac",
  description:
    "Plateforme gratuite de révision pour le baccalauréat africain. Fiches, quiz et schémas pour réussir ton Bac.",
  openGraph: {
    title: "BacSuccess - Réussis ton Bac. Point final.",
    description:
      "Plateforme gratuite de révision pour le baccalauréat africain. Fiches interactives, quiz et schémas de synthèse.",
    url: "https://bacsuccess.vercel.app",
    siteName: "BacSuccess",
    locale: "fr_FR",
    type: "website",
    images: [
      {
        url: "/og-image.png",
        width: 1200,
        height: 630,
        alt: "BacSuccess - Réussis ton Bac",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "BacSuccess - Réussis ton Bac. Point final.",
    description:
      "Plateforme gratuite de révision pour le baccalauréat africain.",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr" suppressHydrationWarning>
      <body
        className={`${plusJakarta.variable} ${dmSans.variable} antialiased`}
      >
        <ThemeProvider>
          {children}
        </ThemeProvider>
        {process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID && (
          <Script
            src="https://cloud.umami.is/script.js"
            data-website-id={process.env.NEXT_PUBLIC_UMAMI_WEBSITE_ID}
            strategy="lazyOnload"
          />
        )}
      </body>
    </html>
  );
}
