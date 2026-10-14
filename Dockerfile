# Stage 1: compile the CV
FROM texlive/texlive:latest-small AS build
WORKDIR /cv
COPY src/ src/
RUN mkdir -p /cv/out && pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/cv/out src/Nandakishore_Vinayakrishnan_CV.tex \
 && pdflatex -interaction=nonstopmode -halt-on-error -output-directory=/cv/out src/Nandakishore_Vinayakrishnan_CV.tex \
 && mv /cv/out/Nandakishore_Vinayakrishnan_CV.pdf /cv/out/cv.pdf

# Stage 2: serve it
FROM nginx:1.27-alpine
COPY site/index.html /usr/share/nginx/html/index.html
COPY --from=build /cv/out/cv.pdf /usr/share/nginx/html/cv.pdf
EXPOSE 80
