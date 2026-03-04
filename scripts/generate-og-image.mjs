import { createCanvas } from 'canvas'
import { writeFileSync } from 'fs'
import { resolve, dirname } from 'path'
import { fileURLToPath } from 'url'

const __dirname = dirname(fileURLToPath(import.meta.url))

const WIDTH = 1200
const HEIGHT = 630

const canvas = createCanvas(WIDTH, HEIGHT)
const ctx = canvas.getContext('2d')

// Background - dark green
ctx.fillStyle = '#1B4332'
ctx.fillRect(0, 0, WIDTH, HEIGHT)

// Subtle gradient overlay
const gradient = ctx.createLinearGradient(0, 0, WIDTH, HEIGHT)
gradient.addColorStop(0, 'rgba(27, 67, 50, 1)')
gradient.addColorStop(1, 'rgba(13, 40, 28, 1)')
ctx.fillStyle = gradient
ctx.fillRect(0, 0, WIDTH, HEIGHT)

// Decorative circles (subtle)
ctx.globalAlpha = 0.05
ctx.fillStyle = '#D4A017'
ctx.beginPath()
ctx.arc(100, 100, 200, 0, Math.PI * 2)
ctx.fill()
ctx.beginPath()
ctx.arc(1100, 530, 250, 0, Math.PI * 2)
ctx.fill()
ctx.globalAlpha = 1

// Graduation cap icon (simplified)
ctx.fillStyle = '#D4A017'
const capX = WIDTH / 2
const capY = 180
// Cap top (diamond shape)
ctx.beginPath()
ctx.moveTo(capX, capY - 40)
ctx.lineTo(capX + 70, capY)
ctx.lineTo(capX, capY + 20)
ctx.lineTo(capX - 70, capY)
ctx.closePath()
ctx.fill()
// Cap body
ctx.fillStyle = '#D4A017'
ctx.beginPath()
ctx.moveTo(capX - 45, capY + 5)
ctx.lineTo(capX - 45, capY + 35)
ctx.quadraticCurveTo(capX, capY + 55, capX + 45, capY + 35)
ctx.lineTo(capX + 45, capY + 5)
ctx.closePath()
ctx.fill()
// Tassel
ctx.strokeStyle = '#D4A017'
ctx.lineWidth = 3
ctx.beginPath()
ctx.moveTo(capX + 70, capY)
ctx.lineTo(capX + 70, capY + 45)
ctx.stroke()
ctx.beginPath()
ctx.arc(capX + 70, capY + 48, 5, 0, Math.PI * 2)
ctx.fill()

// Title
ctx.fillStyle = '#FFFFFF'
ctx.font = 'bold 72px sans-serif'
ctx.textAlign = 'center'
ctx.fillText('BacSuccess', WIDTH / 2, 320)

// Tagline
ctx.fillStyle = 'rgba(255, 255, 255, 0.9)'
ctx.font = '32px sans-serif'
ctx.fillText('Réussis ton Bac. Point final.', WIDTH / 2, 380)

// Badge "Gratuit"
const badgeText = 'Gratuit'
ctx.font = 'bold 22px sans-serif'
const badgeWidth = ctx.measureText(badgeText).width + 40
const badgeX = WIDTH / 2 - badgeWidth / 2
const badgeY = 420
// Badge background
ctx.fillStyle = '#D4A017'
const radius = 20
ctx.beginPath()
ctx.roundRect(badgeX, badgeY, badgeWidth, 44, radius)
ctx.fill()
// Badge text
ctx.fillStyle = '#1B4332'
ctx.font = 'bold 22px sans-serif'
ctx.textAlign = 'center'
ctx.fillText(badgeText, WIDTH / 2, badgeY + 30)

// Subtitle
ctx.fillStyle = 'rgba(255, 255, 255, 0.6)'
ctx.font = '20px sans-serif'
ctx.textAlign = 'center'
ctx.fillText('Fiches interactives · Quiz · Schémas de synthèse', WIDTH / 2, 520)

// Bottom bar
ctx.fillStyle = '#D4A017'
ctx.fillRect(0, HEIGHT - 6, WIDTH, 6)

const buffer = canvas.toBuffer('image/png')
const outputPath = resolve(__dirname, '..', 'public', 'og-image.png')
writeFileSync(outputPath, buffer)
console.log(`OG image generated: ${outputPath}`)
