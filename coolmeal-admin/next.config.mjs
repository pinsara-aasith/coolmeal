/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  experimental: {
    instrumentationHook: true,
    esmExternals: "loose", 
    serverComponentsExternalPackages: ["mongoose"]
  },
  eslint: {
    ignoreDuringBuilds: true,
  }
}

export default nextConfig;

