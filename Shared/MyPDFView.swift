//
//  MyPDFView.swift
//  mmCanvas
//
//  Created by SATOSHI NAKAJIMA on 8/30/20.
//

import SwiftUI
import PDFKit

struct MyPDFView: UIViewRepresentable {
    let url: URL
    init(_ url:URL) {
        self.url = url
    }
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        pdfView.displayMode = .singlePage
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct MyPDFView_Previews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "teslaQ2_2020", withExtension: "pdf")
        MyPDFView(url!)
    }
}
