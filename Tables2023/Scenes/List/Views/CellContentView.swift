//
//  CellContentView.swift
//  Tables2023
//
//  Created by Miguel Rojas Cortes on 1/8/23.
//

import UIKit

final class CellContentView: UIView {

    // MARK: - Properties

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.alignment = .top
        return stackView
    }()

    private lazy var symbolImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "pencil.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .red
        return imageView
    }()

    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers

    init(text: String) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        configure(model: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        addSubview(horizontalStackView)
        addSubview(separatorView)
        horizontalStackView.addArrangedSubview(symbolImageView)
        horizontalStackView.addArrangedSubview(headlineLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            separatorView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 12),
            separatorView.leadingAnchor.constraint(equalTo: headlineLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: headlineLabel.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    // MARK: - Configuration

    private func configure(model: String) {
        headlineLabel.text = model
    }

}
