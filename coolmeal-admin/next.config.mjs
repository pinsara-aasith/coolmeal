/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  // Allow images from unsplash.com
  experimental: {
		instrumentationHook: true,
	}
}

export default nextConfig;

